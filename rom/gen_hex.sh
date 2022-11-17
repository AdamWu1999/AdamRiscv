#!/usr/bin/bash
#new_name=${1%.*}_s
riscv32-unknown-elf-gcc  -c -static -Ttext 0x00000000 $2/$1 -o $2/main_s.o -march=rv32i -mabi=ilp32
riscv32-unknown-elf-objdump -S -l $2/main_s.o -M no-aliases,numeric >$2/main_s.dump
riscv32-unknown-elf-objcopy $2/main_s.o -O verilog $2/main_s.verilog

