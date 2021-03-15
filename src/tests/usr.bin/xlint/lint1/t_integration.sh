# $NetBSD: t_integration.sh,v 1.33 2021/03/07 19:42:54 rillig Exp $
#
# Copyright (c) 2008, 2010 The NetBSD Foundation, Inc.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE NETBSD FOUNDATION, INC. AND CONTRIBUTORS
# ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
# TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE FOUNDATION OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
#

LINT1=/usr/libexec/lint1

Names=

extract_flags()
{
	local extract_flags_awk

	# shellcheck disable=SC2016
	extract_flags_awk='
		BEGIN {
			flags = "-g -S -w"
		}
		/^\/\* (lint1-flags|lint1-extra-flags): .*\*\/$/ {
			if ($2 == "lint1-flags:")
				flags = ""
			for (i = 3; i < NF; i++)
				flags = flags " " $i
		}
		END {
			print flags
		}
	'

	awk "$extract_flags_awk" "$@"
}

# shellcheck disable=SC2155
check_lint1()
{
	local src="$(atf_get_srcdir)/$1"
	local exp="${src%.c}.exp"
	local flags="$(extract_flags "${src}")"

	if [ -f "${exp}" ]; then
		# shellcheck disable=SC2086
		atf_check -s not-exit:0 -o "file:${exp}" -e empty \
		    ${LINT1} ${flags} "${src}" /dev/null
	else
		# shellcheck disable=SC2086
		atf_check -s exit:0 \
		    ${LINT1} ${flags} "${src}" /dev/null
	fi
}

test_case()
{
	local name="${1}"; shift
	local descr="${*}"

	atf_test_case ${name}
	eval "${name}_head() {
		if [ \"${descr}\" ]; then
			atf_set \"descr\" \"${descr}\"
		fi
		atf_set \"require.progs\" \"${LINT1}\"
	}"
	eval "${name}_body() {
		check_lint1 d_${name}.c
	}"

	Names="${Names} ${name}"
}

test_case bltinoffsetof
test_case c99_anon_struct
test_case c99_anon_union
test_case c99_bool
test_case c99_bool_strict
test_case c99_bool_strict_syshdr
test_case c99_compound_literal_comma
test_case c99_decls_after_stmt2
test_case c99_flex_array_packed
test_case c99_init
test_case c99_nested_struct
test_case c99_union_cast
test_case c99_union_init4
test_case c99_union_init5
test_case cast_fun_array_param
test_case cast_typeof
test_case decl_old_style_arguments
test_case fold_test
test_case gcc_extension
test_case init_pop_member
test_case lint_assert
test_case return_type
test_case type_question_colon
test_case typefun
test_case typename_as_var

test_case c99_struct_init
test_case c99_union_init1
test_case c99_union_init2
test_case c99_union_init3
test_case c99_recursive_init
test_case c9x_recursive_init
test_case nested_structs
test_case packed_structs
test_case pr_22119
test_case struct_init_nested

test_case cast_init
test_case cast_init2		"Checks cast initialization as the rhs of a" \
				"- operand"
test_case cast_lhs		"Checks whether pointer casts are valid lhs" \
				"lvalues"

test_case gcc_func		"Checks GCC __FUNCTION__"
test_case c99_func		"Checks C99 __func__"

test_case gcc_variable_array_init "Checks GCC variable array initializers"
test_case c9x_array_init
test_case c99_decls_after_stmt
test_case c99_decls_after_stmt3
test_case nolimit_init		"Checks no limit initializers"
test_case zero_sized_arrays

test_case compound_literals1
test_case compound_literals2
test_case gcc_compound_statements1
test_case gcc_compound_statements2 "Checks GCC compound statements with" \
				"non-expressions"
test_case gcc_compound_statements3 "Checks GCC compound statements with" \
				"void type"
# XXX: Because of polymorphic __builtin_isnan and expression has null effect
# test_case gcc_extension "Checks GCC __extension__ and __typeof__"

test_case cvt_in_ternary	"Checks CVT nodes handling in ?"
test_case cvt_constant		"Checks constant conversion"
test_case ellipsis_in_switch	"Checks ellipsis in switch()"
test_case c99_complex_num	"Checks C99 complex numbers"
test_case c99_complex_split	"Checks C99 complex access"
test_case c99_for_loops
test_case alignof		"Checks __alignof__"
test_case shift_to_narrower_type "Checks that type shifts that result in" \
				"narrower types do not produce warnings"

test_case constant_conv1	"Checks failing on information-losing" \
				"constant conversion in argument lists"
test_case constant_conv2	"Checks failing on information-losing" \
				"constant conversion in argument lists"

test_case type_conv1		"Checks failing on information-losing" \
				"type conversion in argument lists"
test_case type_conv2		"Checks failing on information-losing" \
				"type conversion in argument lists"
test_case type_conv3		"Checks failing on information-losing" \
				"type conversion in argument lists"

test_case incorrect_array_size

test_case long_double_int	"Checks for confusion of 'long double' with" \
				"'long int'; PR bin/39639"

test_case all_messages
all_messages_body()
{
	local srcdir ok msg base flags

	srcdir="$(atf_get_srcdir)"
	ok="true"

	for msg in $(seq 0 340); do
		base="$(printf '%s/msg_%03d' "${srcdir}" "${msg}")"
		flags="$(extract_flags "${base}.c")"

		# shellcheck disable=SC2154 disable=SC2086
		${Atf_Check} -s not-exit:0 -o "file:${base}.exp" -e empty \
		    ${LINT1} ${flags} "${base}.c" /dev/null \
		|| ok="false"
	done

	atf_check "${ok}"
}


atf_init_test_cases()
{
	for name in ${Names}; do
		atf_add_test_case ${name}
	done
}
