.option norvc
.text
lui x1,0xfffff
addi x2,x0,0xff
slli x3,x2,4
addi x3,x3,0xf
add x4,x3,x1
auipc x5,0xfff
