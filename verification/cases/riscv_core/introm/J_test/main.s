
.global main
main:
lui x6,0x1234
auipc x7,0x8765
sw  x6,0x0(x0)
sw  x7,0x4(x0)
jal ra,string1   
sh  x6,0x0(x0)
sh  x7,0x4(x0)
string1:
sb  x6,0x2(x0)
sb  x7,0x7(x0)
exit:
