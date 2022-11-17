from os import close
import re 
pattern = re.compile('.{8}')
inner_pattern = re.compile('(.{2})(.{2})(.{2})(.{2})')
file = open("./rom/main_s.verilog",'r')
lines = file.readlines()

coe_content = '''memory_initialization_radix=16;
memory_initialization_vector=#CONTENT_HERE;
'''

newfile = ""
new_file = open("./rom/main_s_fpga.coe",'w')
for i in lines:
    #print(i)
    if i[0] != "@":
        i =  i.replace(" ","")
        i = pattern.findall(i)
        for j in range(len(i)):
            temp = inner_pattern.match(i[j])
            i[j]= temp.group(4)+temp.group(3)+temp.group(2)+temp.group(1)
        newfile = newfile + '\n'.join(i) +'\n'
        #newfile = newfile + '\n'
line_count = newfile.count("\n")
'''
for i in range(4096-line_count):
    newfile = newfile + "00000000\n"
'''
newfile = newfile.replace("\n",",")
newfile = newfile.strip(",")
print(newfile)
#print(line_count)
coe_content = coe_content.replace("#CONTENT_HERE",newfile)

new_file.write(coe_content)
file.close()
new_file.close()