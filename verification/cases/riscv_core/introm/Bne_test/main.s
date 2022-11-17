
.global main
main:
lui x1,0x40   
lui x2,0x40   
lui x3,0x50   

bne x1,x3,string1
lui x4,0x60   
string1:
lui x5,0x70
lui x6,0x80
exit:
