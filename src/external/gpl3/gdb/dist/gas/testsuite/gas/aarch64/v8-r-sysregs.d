#name: Exhaustive test of Armv8-R system registers
#as: -march=armv8-r
#objdump: -dr -m aarch64:armv8-r

.*:     file format .*

Disassembly of section \.text:

0+ <.*>:
.*:	d5380080 	mrs	x0, mpuir_el1
.*:	d53c0080 	mrs	x0, mpuir_el2
.*:	d5386800 	mrs	x0, prbar_el1
.*:	d5186800 	msr	prbar_el1, x0
.*:	d53c6800 	mrs	x0, prbar_el2
.*:	d51c6800 	msr	prbar_el2, x0
.*:	d5386880 	mrs	x0, prbar1_el1
.*:	d5186880 	msr	prbar1_el1, x0
.*:	d5386900 	mrs	x0, prbar2_el1
.*:	d5186900 	msr	prbar2_el1, x0
.*:	d5386980 	mrs	x0, prbar3_el1
.*:	d5186980 	msr	prbar3_el1, x0
.*:	d5386a00 	mrs	x0, prbar4_el1
.*:	d5186a00 	msr	prbar4_el1, x0
.*:	d5386a80 	mrs	x0, prbar5_el1
.*:	d5186a80 	msr	prbar5_el1, x0
.*:	d5386b00 	mrs	x0, prbar6_el1
.*:	d5186b00 	msr	prbar6_el1, x0
.*:	d5386b80 	mrs	x0, prbar7_el1
.*:	d5186b80 	msr	prbar7_el1, x0
.*:	d5386c00 	mrs	x0, prbar8_el1
.*:	d5186c00 	msr	prbar8_el1, x0
.*:	d5386c80 	mrs	x0, prbar9_el1
.*:	d5186c80 	msr	prbar9_el1, x0
.*:	d5386d00 	mrs	x0, prbar10_el1
.*:	d5186d00 	msr	prbar10_el1, x0
.*:	d5386d80 	mrs	x0, prbar11_el1
.*:	d5186d80 	msr	prbar11_el1, x0
.*:	d5386e00 	mrs	x0, prbar12_el1
.*:	d5186e00 	msr	prbar12_el1, x0
.*:	d5386e80 	mrs	x0, prbar13_el1
.*:	d5186e80 	msr	prbar13_el1, x0
.*:	d5386f00 	mrs	x0, prbar14_el1
.*:	d5186f00 	msr	prbar14_el1, x0
.*:	d5386f80 	mrs	x0, prbar15_el1
.*:	d5186f80 	msr	prbar15_el1, x0
.*:	d53c6880 	mrs	x0, prbar1_el2
.*:	d51c6880 	msr	prbar1_el2, x0
.*:	d53c6900 	mrs	x0, prbar2_el2
.*:	d51c6900 	msr	prbar2_el2, x0
.*:	d53c6980 	mrs	x0, prbar3_el2
.*:	d51c6980 	msr	prbar3_el2, x0
.*:	d53c6a00 	mrs	x0, prbar4_el2
.*:	d51c6a00 	msr	prbar4_el2, x0
.*:	d53c6a80 	mrs	x0, prbar5_el2
.*:	d51c6a80 	msr	prbar5_el2, x0
.*:	d53c6b00 	mrs	x0, prbar6_el2
.*:	d51c6b00 	msr	prbar6_el2, x0
.*:	d53c6b80 	mrs	x0, prbar7_el2
.*:	d51c6b80 	msr	prbar7_el2, x0
.*:	d53c6c00 	mrs	x0, prbar8_el2
.*:	d51c6c00 	msr	prbar8_el2, x0
.*:	d53c6c80 	mrs	x0, prbar9_el2
.*:	d51c6c80 	msr	prbar9_el2, x0
.*:	d53c6d00 	mrs	x0, prbar10_el2
.*:	d51c6d00 	msr	prbar10_el2, x0
.*:	d53c6d80 	mrs	x0, prbar11_el2
.*:	d51c6d80 	msr	prbar11_el2, x0
.*:	d53c6e00 	mrs	x0, prbar12_el2
.*:	d51c6e00 	msr	prbar12_el2, x0
.*:	d53c6e80 	mrs	x0, prbar13_el2
.*:	d51c6e80 	msr	prbar13_el2, x0
.*:	d53c6f00 	mrs	x0, prbar14_el2
.*:	d51c6f00 	msr	prbar14_el2, x0
.*:	d53c6f80 	mrs	x0, prbar15_el2
.*:	d51c6f80 	msr	prbar15_el2, x0
.*:	d5386120 	mrs	x0, prenr_el1
.*:	d5186120 	msr	prenr_el1, x0
.*:	d53c6120 	mrs	x0, prenr_el2
.*:	d51c6120 	msr	prenr_el2, x0
.*:	d5386820 	mrs	x0, prlar_el1
.*:	d5186820 	msr	prlar_el1, x0
.*:	d53c6820 	mrs	x0, prlar_el2
.*:	d51c6820 	msr	prlar_el2, x0
.*:	d53868a0 	mrs	x0, prlar1_el1
.*:	d51868a0 	msr	prlar1_el1, x0
.*:	d5386920 	mrs	x0, prlar2_el1
.*:	d5186920 	msr	prlar2_el1, x0
.*:	d53869a0 	mrs	x0, prlar3_el1
.*:	d51869a0 	msr	prlar3_el1, x0
.*:	d5386a20 	mrs	x0, prlar4_el1
.*:	d5186a20 	msr	prlar4_el1, x0
.*:	d5386aa0 	mrs	x0, prlar5_el1
.*:	d5186aa0 	msr	prlar5_el1, x0
.*:	d5386b20 	mrs	x0, prlar6_el1
.*:	d5186b20 	msr	prlar6_el1, x0
.*:	d5386ba0 	mrs	x0, prlar7_el1
.*:	d5186ba0 	msr	prlar7_el1, x0
.*:	d5386c20 	mrs	x0, prlar8_el1
.*:	d5186c20 	msr	prlar8_el1, x0
.*:	d5386ca0 	mrs	x0, prlar9_el1
.*:	d5186ca0 	msr	prlar9_el1, x0
.*:	d5386d20 	mrs	x0, prlar10_el1
.*:	d5186d20 	msr	prlar10_el1, x0
.*:	d5386da0 	mrs	x0, prlar11_el1
.*:	d5186da0 	msr	prlar11_el1, x0
.*:	d5386e20 	mrs	x0, prlar12_el1
.*:	d5186e20 	msr	prlar12_el1, x0
.*:	d5386ea0 	mrs	x0, prlar13_el1
.*:	d5186ea0 	msr	prlar13_el1, x0
.*:	d5386f20 	mrs	x0, prlar14_el1
.*:	d5186f20 	msr	prlar14_el1, x0
.*:	d5386fa0 	mrs	x0, prlar15_el1
.*:	d5186fa0 	msr	prlar15_el1, x0
.*:	d53c68a0 	mrs	x0, prlar1_el2
.*:	d51c68a0 	msr	prlar1_el2, x0
.*:	d53c6920 	mrs	x0, prlar2_el2
.*:	d51c6920 	msr	prlar2_el2, x0
.*:	d53c69a0 	mrs	x0, prlar3_el2
.*:	d51c69a0 	msr	prlar3_el2, x0
.*:	d53c6a20 	mrs	x0, prlar4_el2
.*:	d51c6a20 	msr	prlar4_el2, x0
.*:	d53c6aa0 	mrs	x0, prlar5_el2
.*:	d51c6aa0 	msr	prlar5_el2, x0
.*:	d53c6b20 	mrs	x0, prlar6_el2
.*:	d51c6b20 	msr	prlar6_el2, x0
.*:	d53c6ba0 	mrs	x0, prlar7_el2
.*:	d51c6ba0 	msr	prlar7_el2, x0
.*:	d53c6c20 	mrs	x0, prlar8_el2
.*:	d51c6c20 	msr	prlar8_el2, x0
.*:	d53c6ca0 	mrs	x0, prlar9_el2
.*:	d51c6ca0 	msr	prlar9_el2, x0
.*:	d53c6d20 	mrs	x0, prlar10_el2
.*:	d51c6d20 	msr	prlar10_el2, x0
.*:	d53c6da0 	mrs	x0, prlar11_el2
.*:	d51c6da0 	msr	prlar11_el2, x0
.*:	d53c6e20 	mrs	x0, prlar12_el2
.*:	d51c6e20 	msr	prlar12_el2, x0
.*:	d53c6ea0 	mrs	x0, prlar13_el2
.*:	d51c6ea0 	msr	prlar13_el2, x0
.*:	d53c6f20 	mrs	x0, prlar14_el2
.*:	d51c6f20 	msr	prlar14_el2, x0
.*:	d53c6fa0 	mrs	x0, prlar15_el2
.*:	d51c6fa0 	msr	prlar15_el2, x0
.*:	d5386220 	mrs	x0, prselr_el1
.*:	d5186220 	msr	prselr_el1, x0
.*:	d53c6220 	mrs	x0, prselr_el2
.*:	d51c6220 	msr	prselr_el2, x0
.*:	d53c2000 	mrs	x0, vsctlr_el2
.*:	d51c2000 	msr	vsctlr_el2, x0