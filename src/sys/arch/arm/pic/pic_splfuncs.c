/*	$NetBSD: pic_splfuncs.c,v 1.19 2021/03/01 11:29:14 jmcneill Exp $	*/
/*-
 * Copyright (c) 2008 The NetBSD Foundation, Inc.
 * All rights reserved.
 *
 * This code is derived from software contributed to The NetBSD Foundation
 * by Matt Thomas.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE NETBSD FOUNDATION, INC. AND CONTRIBUTORS
 * ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE FOUNDATION OR CONTRIBUTORS
 * BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */
#include <sys/cdefs.h>
__KERNEL_RCSID(0, "$NetBSD: pic_splfuncs.c,v 1.19 2021/03/01 11:29:14 jmcneill Exp $");

#define _INTR_PRIVATE
#include <sys/param.h>
#include <sys/atomic.h>
#include <sys/evcnt.h>
#include <sys/lwp.h>
#include <sys/kernel.h>

#include <dev/cons.h>

#include <arm/armreg.h>
#include <arm/cpu.h>
#include <arm/cpufunc.h>
#include <arm/locore.h>	/* for compat aarch64 */

#include <arm/pic/picvar.h>

#if defined(__HAVE_CPU_DOSOFTINTS_CI)
#define	CPU_DOSOFTINTS(ci)	cpu_dosoftints_ci((ci))
#else
#define	CPU_DOSOFTINTS(ci)	cpu_dosoftints()
#endif

#if defined(__HAVE_PIC_PENDING_INTRS)
static void	splx_dopendingints(struct cpu_info *, const int);
#endif

int
_splraise(int newipl)
{
	struct cpu_info * const ci = curcpu();
	const int oldipl = ci->ci_cpl;
	KDASSERT(newipl < NIPL);
	if (newipl > ci->ci_cpl) {
		pic_set_priority(ci, newipl);
	}
	return oldipl;
}

int
_spllower(int newipl)
{
	struct cpu_info * const ci = curcpu();
	const int oldipl = ci->ci_cpl;
	KDASSERT(panicstr || newipl <= ci->ci_cpl);
	if (newipl < ci->ci_cpl) {
		register_t psw = DISABLE_INTERRUPT_SAVE();
		ci->ci_intr_depth++;
		pic_do_pending_ints(psw, newipl, NULL);
		ci->ci_intr_depth--;
		if ((psw & I32_bit) == 0 || newipl == IPL_NONE) {
			ENABLE_INTERRUPT();
		}
		cpu_dosoftints();
	}
	return oldipl;
}

void
splx(int savedipl)
{
	struct cpu_info * const ci = curcpu();
	KDASSERT(savedipl < NIPL);

	if (__predict_false(savedipl == ci->ci_cpl)) {
		return;
	}

#if defined(__HAVE_PIC_PENDING_INTRS)
	if (__predict_false(ci->ci_pending_ipls != 0)) {
		splx_dopendingints(ci, savedipl);
	}
#endif

	pic_set_priority(ci, savedipl);
	CPU_DOSOFTINTS(ci);

	KDASSERTMSG(ci->ci_cpl == savedipl, "cpl %d savedipl %d",
	    ci->ci_cpl, savedipl);
}

#if defined(__HAVE_PIC_PENDING_INTRS)
static void __noinline
splx_dopendingints(struct cpu_info *ci, const int savedipl)
{
	const register_t psw = DISABLE_INTERRUPT_SAVE();
	ci->ci_intr_depth++;
	while ((ci->ci_pending_ipls & ~__BIT(savedipl)) > __BIT(savedipl)) {
		KASSERT(ci->ci_pending_ipls < __BIT(NIPL));
		for (;;) {
			int ipl = 31 - __builtin_clz(ci->ci_pending_ipls);
			KASSERT(ipl < NIPL);
			if (ipl <= savedipl) {
				break;
			}

			pic_set_priority(ci, ipl);
			pic_list_deliver_irqs(ci, psw, ipl, NULL);
			pic_list_unblock_irqs(ci);
		}
	}
	ci->ci_intr_depth--;
	if ((psw & I32_bit) == 0) {
		ENABLE_INTERRUPT();
	}
}
#endif
