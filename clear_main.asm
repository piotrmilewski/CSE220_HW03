.data
hash_table:
.word 11   # capacity is always valid
.word 163  # random junk for size
.word 181, 982, 668, 707, 957, 768, 762, 618, 59, 113, 599 # random junk for keys
.word 285, 915, 539, 761, 360, 954, 561, 599, 912, 985, 4  # random junk for values

.text
.globl main
main:
la $a0, hash_table
jal clear

# You should probably write code here to print the state of the hash table.

li $v0, 10
syscall

.include "proj3.asm"
