from os import close


file = open("./rom/test_program3.txt",'r')
lines = file.readlines()
newfile = ""
new_file = open("./rom/test3_program.txt",'w')
for i in lines:
    print(i)
    newfile = newfile + i[6] + i[7] + "\n"
    newfile = newfile + i[4] + i[5] + "\n"
    newfile = newfile + i[2] + i[3] + "\n"
    newfile = newfile + i[0] + i[1] + "\n"

print(newfile)
new_file.write(newfile)
file.close()
new_file.close()