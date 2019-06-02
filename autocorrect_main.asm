.data
v0: .asciiz "v0: "
dest_msg: .asciiz "dest: "
buffer_msg: .asciiz "buffer after jal: "

hash_table:
.word 29
.word 213
.word 842, 625, 656, 541, 580, 830, 985, 324, 14, 409, 916, 789, 663, 527, 446, 703, 553, 655, 817, 684, 612, 913, 855, 499, 535, 686, 431, 385, 524
.word 34, 869, 774, 662, 187, 745, 841, 86, 937, 500, 675, 270, 176, 344, 347, 569, 402, 907, 77, 742, 469, 398, 588, 799, 346, 18, 195, 602, 92

strings: .ascii "kk\0cs\0Stony Brook University\0what\0yuo\0CSE 220\0argh\0oh\0OK thanks\0arrgghh\0u\0101\0hmmmm\0good game\0Universal Serial Bus\0you\0help\0sto\0gg\0Stony Brook\0subtraction\0Boise State University\0thx\0OH\0silly\0sillllllly\0thanks\0hepl\0hmm\0can\0usb\0wat\0calss\0sbu\0220\0MIPS\0class\0CSE101\0Applied Mathematics\0ams\0bsu\0i\0cna\0MIPSR10000\0sub\0you\0Computer Science\0I\0"
strings_length: .word 334
filename: .asciiz "C:/Users/piotr/Documents/proj3/subs1.txt"

src: .ascii "I left my usb drive in the ams classroom. thx for returning it!\0"
dest: .ascii "gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg"
buffer: .asciiz "123456789"  # when printed after the function call, this string should not be changed 

.text
.globl main
main:
la $a0, hash_table
la $a1, src
la $a2, dest
la $a3, strings
addi $sp, $sp, -8
lw $t0, strings_length
sw $t0, 0($sp)
la $t0, filename
sw $t0, 4($sp)
jal autocorrect
addi $sp, $sp, 8
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

la $a0, dest_msg
li $v0, 4
syscall
la $a0, dest
li $v0, 4
syscall
li $a0, '\n'
li $v0, 11
syscall

la $a0, buffer_msg
li $v0, 4
syscall
la $a0, buffer
li $v0, 4
syscall
li $a0, '\n'
li $v0, 11
syscall

li $v0, 10
syscall

.include "proj3.asm"
