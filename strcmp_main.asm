.data
v0: .asciiz "v0: "
str1: .asciiz "StonyBrook"
str2: .asciiz "Stony"

.text
.globl main
main:
la $a0, str1
la $a1, str2
jal strcmp
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
