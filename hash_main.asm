.data
v0: .asciiz "v0: "

hash_table:
.word 7
.word 0
.word 0, 0, 0, 0, 0, 0, 0
.word 0, 0, 0, 0, 0, 0, 0

can: .asciiz "can"
Stony_Brook_University: .asciiz "Stony Brook University"
oh: .asciiz "oh"
ams: .asciiz "class"
hepl: .asciiz "hepl"

.text
.globl main
main:
la $a0, hash_table
la $a1, ams
jal hash
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
