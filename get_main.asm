.data
.data
v0: .asciiz "v0: "
v1: .asciiz "v1: "

hash_table:
.word 7
.word 7
.word s101, ams, cs, oh, kk, thx, yuo
.word CSE101, Applied_Mathematics, Computer_Science, OH, OK_thanks, thanks, you

# There are some extra strings here you can work with. Or add your own!
subtraction: .asciiz "subtraction"
s101: .asciiz "101"
sbu: .asciiz "sbu"
yuo: .asciiz "yuo"
u: .asciiz "u"
you: .asciiz "you"
wat: .asciiz "wat"
ams: .asciiz "ams"
help: .asciiz "help"
CSE101: .asciiz "CSE101"
bsu: .asciiz "bsu"
arrgghh: .asciiz "arrgghh"
calss: .asciiz "calss"
thx: .asciiz "thx"
Applied_Mathematics: .asciiz "Applied Mathematics"
hepl: .asciiz "hepl"
OK_thanks: .asciiz "OK thanks"
class: .asciiz "class"
can: .asciiz "can"
kk: .asciiz "kk"
i: .asciiz "i"
thanks: .asciiz "thanks"
usb: .asciiz "usb"
cs: .asciiz "Computer Science"
oh: .asciiz "oh"
gg: .asciiz "gg"
Universal_Serial_Bus: .asciiz "Universal_Serial_Bus"
I: .asciiz "I"
Computer_Science: .asciiz "Computer Science"
OH: .asciiz "OH"

.text
.globl main
main:
la $a0, hash_table
la $a1, gg
jal get
move $t0, $v0
move $t1, $v1

la $a0, v0
li $v0, 4
syscall
li $v0, 1
move $a0, $t0
syscall
li $a0, '\n'
li $v0, 11
syscall

la $a0, v1
li $v0, 4
syscall
li $v0, 1
move $a0, $t1
syscall
li $a0, '\n'
li $v0, 11
syscall

li $v0, 10
syscall


.include "proj3.asm"
