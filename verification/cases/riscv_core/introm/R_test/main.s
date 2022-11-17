.option norvc
.text
lui x1,0xFFFF8
lui x2,0xa
add x3,x1,x2
auipc x13,0x0

srl x2,x2,x13
srl x3,x3,x13

sub x4,x2,x3
sll x5,x4,x3
slt x6,x1,x2
sltu x7,x1,x2
xor x8,x3,x4
srl x9,x8,x3
sra x10,x8,x3
or x11,x10,x9
add x12,x7,x6

