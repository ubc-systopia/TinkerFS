#as: -mno-relax
#objdump: -r

.*:[ 	]+file format .*

RELOCATION RECORDS FOR .*
.*
0+0 R_RISCV_HI20.*
0+4 R_RISCV_LO12_I.*
0+8 R_RISCV_PCREL_HI20.*
0+c R_RISCV_PCREL_LO12_I.*
0+10 R_RISCV_GOT_HI20.*
0+14 R_RISCV_PCREL_LO12_I.*
0+18 R_RISCV_CALL.*