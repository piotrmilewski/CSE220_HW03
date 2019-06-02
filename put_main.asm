.data
v0: .asciiz "v0: "
v1: .asciiz "v1: "

hash_table:
.word 7
.word 5
.word s101, oh, 0, 0, kk, thx, yuo
.word CSE101, OH, 0, 0, OK_thanks, thanks, you

s101: .asciiz "101"
you: .asciiz "you"
arrgghh: .asciiz "arrgghh"
subtraction: .asciiz "subtraction"
CSE_220: .asciiz "CSE 220"
MIPS: .asciiz "MIPS"
Boise_State_University: .asciiz "Boise State University"
sillllllly: .asciiz "sillllllly"
usb: .asciiz "usb"
i: .asciiz "i"
CSE101: .asciiz "CSE101"
class: .asciiz "class"
I: .asciiz "I"
cs: .asciiz "cs"
hmmmm: .asciiz "hmmmm"
hepl: .asciiz "hepl"
help: .asciiz "help"
Computer_Science: .asciiz "Computer Science"
can: .asciiz "can"
OK_thanks: .asciiz "OK thanks"
Applied_Mathematics: .asciiz "Applied Mathematics"
MIPSR10000: .asciiz "MIPSR10000"
ams: .asciiz "ams"
kk: .asciiz "kk"
silly: .asciiz "silly"
gg: .asciiz "gg"
OH: .asciiz "OH"
what: .asciiz "what"
argh: .asciiz "argh"
sto: .asciiz "sto"
sbu: .asciiz "sbu"
yuo: .asciiz "yuo"
thx: .asciiz "thx"
Stony_Brook_University: .asciiz "Stony Brook University"
wat: .asciiz "wat"
Universal_Serial_Bus: .asciiz "Universal Serial Bus"
hmm: .asciiz "hmm"
cna: .asciiz "cna"
bsu: .asciiz "bsu"
u: .asciiz "u"
good_game: .asciiz "good game"
oh: .asciiz "oh"
thanks: .asciiz "thanks"
sub: .asciiz "sub"
Stony_Brook: .asciiz "Stony Brook"
calss: .asciiz "calss"

.text
.globl main
main:
la $a0, hash_table
la $a1, oh
la $a2, OH
jal put
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

# You should probably write code here to print the state of the hash table.

li $v0, 10
syscall

.include "proj3.asm"
