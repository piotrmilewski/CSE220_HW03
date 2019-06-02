.data
v0: .asciiz "v0: "
target: .asciiz "MIPS"
strings: .ascii "thanks\0thx\0CSE 220\0CSE 215\0can\0\0dm\0220\0help\0cna\0hepl\0"
strings_length: .word 53

.text
.globl main
main:
la $a0, target
la $a1, strings
lw $a2, strings_length
jal find_string
move $t0, $v0

la $a0, v0
li $v0, 4
syscall
li $v0, 1
move $a0, $t0
syscall
li $a0, '\n'
li $v0, 11
syscall

li $v0, 10
syscall

.include "proj3.asm"
