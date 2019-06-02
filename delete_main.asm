.data
v0: .asciiz "v0: "
v1: .asciiz "v1: "

hash_table:
.word 7
.word 7
.word s101, ams, cs, oh, kk, thx, yuo
.word CSE101, Applied_Mathematics, Computer_Science, OH, OK_thanks, thanks, you

good_game: .asciiz "good game"
sillllllly: .asciiz "sillllllly"
hmm: .asciiz "hmm"
s220: .asciiz "220"
Computer_Science: .asciiz "Computer Science"
cs: .asciiz "cs"
I: .asciiz "I"
Stony_Brook_University: .asciiz "Stony Brook University"
i: .asciiz "i"
help: .asciiz "help"
what: .asciiz "what"
OK_thanks: .asciiz "OK thanks"
hmmmm: .asciiz "hmmmm"
u: .asciiz "u"
hepl: .asciiz "hepl"
CSE101: .asciiz "CSE101"
ams: .asciiz "ams"
thx: .asciiz "thx"
silly: .asciiz "silly"
yuo: .asciiz "yuo"
Boise_State_University: .asciiz "Boise State University"
subtraction: .asciiz "subtraction"
OH: .asciiz "OH"
sto: .asciiz "sto"
wat: .asciiz "wat"
sbu: .asciiz "sbu"
sub: .asciiz "sub"
MIPS: .asciiz "MIPS"
s101: .asciiz "101"
kk: .asciiz "kk"
Universal_Serial_Bus: .asciiz "Universal Serial Bus"
calss: .asciiz "calss"
bsu: .asciiz "bsu"
you: .asciiz "you"
can: .asciiz "can"
MIPSR10000: .asciiz "MIPSR10000"
oh: .asciiz "oh"
cna: .asciiz "cna"
class: .asciiz "class"
thanks: .asciiz "thanks"
gg: .asciiz "gg"
usb: .asciiz "usb"
Stony_Brook: .asciiz "Stony Brook"
argh: .asciiz "argh"
arrgghh: .asciiz "arrgghh"
Applied_Mathematics: .asciiz "Applied Mathematics"
CSE_220: .asciiz "CSE 220"


.text
.globl main
main:
la $a0, hash_table
la $a1, gg
jal delete
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
