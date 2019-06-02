###############################################################
# 
# IMPORTANT NOTES
#
# The filename you provide should be given in an absolute path.
# Example: C:/Users/Joe/Documents/CSE 220/Project3/hash_table1.txt
#
# Alternatively, you can leave it as a relative path, but then
# you must move MARS into the same directory as the main files.
# Why? Because MARS is a little buggy with file I/O.
#
################################################################

.data
v0: .asciiz "v0: "

hash_table:
.word 13
.word 398
.word 588, 799, 346, 18, 195, 602, 92, 853, 645, 374, 15, 919, 362
.word 236, 417, 546, 515, 743, 845, 932, 63, 656, 296, 508, 989, 784

strings: .ascii "wat\0class range\0usb\0I\0gg\0price hose\0hmmmm\0disimprison\0can\0hmm\0Applied Mathematics\0defuze\0Universal Serial Bus\0jazzy\0inapprehensiveness\0OK thanks\0what\0good game\0giftless\0rotate\0sillllllly\0hartselle\0thx\0succinct street\0brockport\0Boise State University\0silly\0class\0billhead\0first floor\0sub\0languid lip\0Stony Brook\0CSE101\0OH\0MIPS\0colorado\0cs\0yuo\0calss\0able\0oh\0help\0sbu\0Stony Brook University\0imbark\0kuwait\0i\0receipt marble\0kk\0MIPSR10000\0fido\0teddy\0second-hand skate\0bsu\0sto\0conclave\0you\0melrose\0subtraction\0altarage\0hepl\0220\0you\0orange clam\0class brush\0Computer Science\0101\0CSE 220 is da best\0argh\0arrgghh\0zebra fruit\0onions\0u\0thanks\0Uni\0cyclamycin\0CSE 220\0ams\0cna\0"
strings_length: .word 661
filename: .asciiz "C:/Users/piotr/Documents/proj3/hash_table1.txt"

.text
.globl main
main:
la $a0, hash_table
la $a1, strings
lw $a2, strings_length
la $a3, filename
jal build_hash_table
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

# You should probably write code here to print the state of the hash table.

li $v0, 10
syscall

.include "proj3.asm"
