# Piotr Milewski
# pmilewski
# 112291666

.text

# t0: holds current char of $a0 (str1)
# t1: holds current char of $a1 (str2)
# t2: 
# t3: 
# t4: 
# t5: 
# t6: 
# t7: TEMP
# t8: holds length of str1
# t9: holds length of str2
strcmp:
	li $v0, 0
	li $t8, 0
	li $t9, 0
	lb $t0, 0($a0)
	lb $t1, 0($a1)
	beqz $t0, strcmp_emptyStr1
	beqz $t1, strcmp_emptyStr2
	strcmp_loop:
		lb $t0, 0($a0)
		lb $t1, 0($a1)
		beqz $t0, strcmp_shortStr1
		beqz $t1, strcmp_shortStr2
		addi $a0, $a0, 1
		addi $a1, $a1, 1
		addi $t8, $t8, 1
		addi $t9, $t9, 1
		bne $t0, $t1, strcmp_diffStr
		j strcmp_loop
	strcmp_diffStr:
		sub $v0, $t0, $t1
		j strcmp_end
	strcmp_shortStr1:
		beq $t0, $t1, strcmp_end
		sub $v0, $t0, $t1
		j strcmp_end
	strcmp_shortStr2:
		sub $v0, $t0, $t1
		j strcmp_end
	strcmp_emptyStr1:
		beqz $t1, strcmp_bothEmpty
		li $t7, 1
		strcmp_emptyStr1_lenStr2:
			lb $t1, 0($a1)
			beqz $t1, strcmp_end
			sub $v0, $v0, $t7
			addi $a1, $a1, 1
			j strcmp_emptyStr1_lenStr2
	strcmp_emptyStr2:
		beqz $t0, strcmp_bothEmpty
		strcmp_emptyStr2_lenStr1:
			lb $t0, 0($a0)
			beqz $t0, strcmp_end
			addi $v0, $v0, 1
			addi $a0, $a0, 1
			j strcmp_emptyStr2_lenStr1
	strcmp_bothEmpty:
		li $v0, 0
		j strcmp_end
	strcmp_end:
		jr $ra
		
# t0: USED BY STRCMP
# t1: USED BY STRCMP
# t2: 
# t3: 
# t4: return value (index)
# t5: current character of string
# t6: whether next word has been reached
# t7: TEMP
# t8: USED BY STRCMP
# t9: USED BY STRCMP
find_string:
	li $t7, 2
	li $t6, 0 #if 0, run strcmp on next character
	li $t4, 0
	blt $a2, $t7, find_string_error
	find_string_loop: 
		beqz $a2, find_string_error
		beqz $t6, find_string_strcmp
		find_string_loop_cont:
			lb $t5, 0($a1)
			bnez $t5, find_string_loop_cont2
			li $t6, 0
		find_string_loop_cont2:
			addi $a1, $a1, 1
			addi $a2, $a2, -1
			addi $t4, $t4, 1
			j find_string_loop
	find_string_strcmp:
		addi $sp, $sp, -16
		sw $a0, 4($sp)
		sw $a1, 8($sp)
		sw $a2, 12($sp)
		sw $ra, 0($sp)
		jal strcmp
		lw $ra, 0($sp)
		lw $a0, 4($sp)
		lw $a1, 8($sp)
		lw $a2, 12($sp)
		addi $sp, $sp, 16
		beqz $v0, find_string_found
		li $t6, 1
		j find_string_loop_cont
	find_string_found:
		move $v0, $t4
		j find_string_end
	find_string_error:
		li $v0, -1
		j find_string_end
	find_string_end:
		jr $ra

# t0: capacity of the hash table
# t1: current character of key
# t2: 
# t3: 
# t4: 
# t5: 
# t6: 
# t7: 
# t8: 
# t9: 
hash:
	lw $t0, 0($a0)
	li $v0, 0
	hash_loop:
		lb $t1, 0($a1)
		beqz $t1, hash_mod
		add $v0, $v0, $t1
		addi $a1, $a1, 1
		j hash_loop
	hash_mod:
		div $v0, $t0
		mfhi $v0
		j hash_end
	hash_end:
		jr $ra

# t0: capacity of the hash table
# t1: total memory of hash table - 1
# t2: 
# t3: 
# t4: 
# t5: 
# t6: 
# t7: TEMP
# t8: 
# t9: 
clear:
	lw $t0, 0($a0)
	li $t1, 1
	li $t7, 0
	add $t1, $t1, $t0
	add $t1, $t1, $t0
	addi $a0, $a0, 4
	clear_loop:
		beqz $t1, clear_end
		sw $t7, 0($a0)
		addi $a0, $a0, 4
		addi $t1, $t1, -1
		j clear_loop		
	clear_end:
		jr $ra

# t0: USED BY STRCMP
# t1: USED BY STRCMP
# t2: 
# t3: 
# t4: modded index of hash table & key
# t5: capacity of the hash table - 1
# t6: v0 return value for hash
# t7: 
# t8: USED BY STRCMP/TEMP
# t9: USED BY STRCMP
get:
	get_hashIndex:
		addi $sp, $sp, -12
		sw $a0, 4($sp)
		sw $a1, 8($sp)
		sw $ra, 0($sp)
		jal hash
		lw $ra, 0($sp)
		lw $a0, 4($sp)
		lw $a1, 8($sp)
		addi $sp, $sp, 12
		move $t6, $v0
	lw $t5, 0($a0)
	addi $t5, $t5, -1
	li $v1, 0 # current probe value
	get_loop:
		# convert index to offset for hash table 
		move $t4, $t6
		li $t8, 4
		mul $t4, $t4, $t8
		addi $t4, $t4, 8
		# apply offset and get key
		add $t4, $t4, $a0
		lw $t4, ($t4)
		beqz $t4, get_keyNotFound
		li $t8, 1
		beq $t4, $t8, get_loop_foundAvailable 
		# strcmp function call
		addi $sp, $sp, -12
		sw $a0, 4($sp)
		sw $a1, 8($sp)
		sw $ra, 0($sp)
		move $a0, $t4
		jal strcmp
		lw $ra, 0($sp)
		lw $a0, 4($sp)
		lw $a1, 8($sp)
		addi $sp, $sp, 12
		beqz $v0, get_keyFound
		get_loop_foundAvailable:
		addi $v1, $v1, 1
		addi $t6, $t6, 1
		ble $t6, $t5, get_loop_indexIsFine
		li $t6, 0
		get_loop_indexIsFine:
		bge $v1, $t5, get_keyNotFound
		j get_loop
	 get_keyFound:
	 	move $v0, $t6
	 	j get_end
	 get_keyNotFound:		
		li $v0, -1
		j get_end	
	get_end:
		jr $ra
 
put:
	# check if key is already in the table
	addi $sp, $sp, -16
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	sw $a2, 12($sp)
	sw $ra, 0($sp)
	jal get
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	lw $a2, 12($sp)
	addi $sp, $sp, 16
	
	# check result of get
	li $t7, -1
	bne $v0, $t7, put_keyExists
	j put_keyNoExist
	# t0: Modded index to insert value
	# t1: capacity of hash table - 1
	# t2: 
	# t3: 
	# t4: 
	# t5: 
	# t6: 
	# t7: TEMP
	# t8: TEMP #2
	# t9:
	put_keyNoExist:
		# check if table is full
		lw $t7, 0($a0)
		lw $t8, 4($a0)
		beq $t8, $t7, put_keyNoExist_noSpaceToInsert
		# get hash key
		addi $sp, $sp, -16
		sw $a0, 4($sp)
		sw $a1, 8($sp)
		sw $a2, 12($sp)
		sw $ra, 0($sp)
		jal hash
		lw $ra, 0($sp)
		lw $a0, 4($sp)
		lw $a1, 8($sp)
		lw $a2, 12($sp)
		addi $sp, $sp, 16
		# start probing for insertion
		li $v1, 0
		lw $t1, 0($a0)
		addi $t1, $t1, -1
		put_keyNoExist_loop:
			move $t0, $v0
			li $t7, 4
			mul $t0, $t0, $t7
			addi $t0, $t0, 8
			add $t0, $t0, $a0 # check this space for 0 or 1
			lw $t0, 0($t0)
			beqz $t0, put_keyNoExist_insertKey
			li $t7, 1
			beq $t0, $t7, put_keyNoExist_insertKey
			addi $v0, $v0, 1
			addi $v1, $v1, 1
			ble $v0, $t1, put_keyNoExist_loop_indexIsFine
			li $v0, 0
			put_keyNoExist_loop_indexIsFine:
			j put_keyNoExist_loop
		# found free spot, insert key
		put_keyNoExist_insertKey:
			# insert the key
			li $t0, 8
			move $t7, $v0
			li $t8, 4
			mul $t7, $t7, $t8
			add $t0, $t0, $t7
			add $t0, $t0, $a0 # now we're where we want to insert the new key
			sw $a1, 0($t0)
			# insert the value
			li $t0, 8
			lw $t7, 0($a0)
			li $t8, 4
			mul $t7, $t7, $t8
			add $t0, $t0, $t7 # now we're at the first value index 
			move $t7, $v0
			li $t8, 4
			mul $t7, $t7, $t8
			add $t0, $t0, $t7 # now we're at the index we want to replace
			add $t0, $t0, $a0 # now we're where we want to insert the new value
			sw $a2, 0($t0)
			# update size
			lw $t7, 4($a0)
			addi $t7, $t7, 1
			sw $t7, 4($a0)
			j put_end
			
		# table is full, can't insert
		put_keyNoExist_noSpaceToInsert:
			li $v0, -1
			li $v1, -1
			j put_end
	
	# t0: Modded index to insert value
	# t1: 
	# t2: 
	# t3: 
	# t4: 
	# t5: 
	# t6: 
	# t7: TEMP
	# t8: TEMP #2
	# t9:
	put_keyExists:
		# convert index to offset for hash table
		li $t0, 8
		lw $t7, 0($a0)
		li $t8, 4
		mul $t7, $t7, $t8
		add $t0, $t0, $t7 # now we're at the first value index 
		move $t7, $v0
		li $t8, 4
		mul $t7, $t7, $t8
		add $t0, $t0, $t7 # now we're at the index we want to replace
		add $t0, $t0, $a0 # now we're where we want to insert the new value
		sw $a2, 0($t0)
		j put_end
		
	put_end:
		jr $ra

# t0: Modded index to delete value
# t1: 
# t2: 
# t3: 
# t4: 
# t5: 
# t6: 
# t7: TEMP
# t8: 
# t9:
delete:
	lw $t7, 4($a0)
	beqz $t7, delete_emptyTable
	# check if key is in table
	addi $sp, $sp, -12
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	sw $ra, 0($sp)
	jal get
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	addi $sp, $sp, 12
	# check if key is found by get
	li $t7, -1
	beq $v0, $t7, delete_keyNotFound
	# key found, delete its values
	# delete the key
	li $t0, 8
	move $t7, $v0
	li $t8, 4
	mul $t7, $t7, $t8
	add $t0, $t0, $t7
	add $t0, $t0, $a0 # now we're where we want to delete the key
	li $t7, 1
	sw $t7, 0($t0)
	# delete the value
	li $t0, 8
	lw $t7, 0($a0)
	li $t8, 4
	mul $t7, $t7, $t8
	add $t0, $t0, $t7 # now we're at the first value index 
	move $t7, $v0
	li $t8, 4
	mul $t7, $t7, $t8
	add $t0, $t0, $t7 # now we're at the index we want to replace
	add $t0, $t0, $a0 # now we're where we want to delete the value
	li $t7, 0
	sw $t7, 0($t0)
	# update size
	lw $t7, 4($a0)
	addi $t7, $t7, -1
	sw $t7, 4($a0)
	j delete_end
	
	delete_keyNotFound:
		j delete_end
	
	delete_emptyTable:
		li $v0, -1
		li $v1, 0
		j delete_end

	delete_end:
		jr $ra

# t0: address of 'hash table'
# t1: address of 'strings'
# t2: address of 'strings_length'
# t3: filename -> file descriptor
# t4: beginning of key in buffer -> starting address of key in strings array
# t5: beginning of value in buffer -> starting address of value in strings array
# t6: current index of buffer
# t7: TEMP
# t8: TEMP #2
# t9: beginning of buffer
build_hash_table:
	addi $sp, $sp, -4
	sw $s0, 0($sp)
	li $s0, 0
	# step 1: clear the hash table
	addi $sp, $sp, -8
	sw $a0, 4($sp)
	sw $ra, 0($sp)
	jal clear
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	addi $sp, $sp, 8
	
	# step 2: Open the file
	# store original arguments
	move $t0, $a0
	move $t1, $a1
	move $t2, $a2
	move $t3, $a3
	# open the file
	move $a0, $t3
	li $a1, 0
	li $a2, 0
	li $v0, 13
	syscall
	# check if the file exists
	li $t7, 0
	move $t3, $v0
	blt $t3, $t7, build_hash_table_fileDoesntExist
	# continue if the file exists
	build_hash_table_initiateKeyGet:
		addi $t9, $sp, -104
		move $t6, $t9
	build_hash_table_getKey:
		move $a0, $t3
		move $a1, $t6
		li $a2, 1
		li $v0, 14
		syscall
		beqz $v0, build_hash_table_noMoreRead
		lb $t8, 0($t6)
		addi $t6, $t6, 1
		li $t7, 32
		beq $t8, $t7, build_hash_table_gotKey
		j build_hash_table_getKey
		
	build_hash_table_gotKey:
		li $t7, 0
		sb $t7, -1($t6)
		addi $sp, $sp, -20
		sw $t0, 4($sp)
		sw $t1, 8($sp)
		sw $t2, 12($sp)
		sw $t3, 16($sp)
		move $a0, $t9
		move $a1, $t1
		move $a2, $t2
		sw $ra, 0($sp)
		jal find_string
		lw $ra, 0($sp)
		lw $t0, 4($sp)
		lw $t1, 8($sp)
		lw $t2, 12($sp)
		lw $t3, 16($sp)
		addi $sp, $sp, 20
		move $t4, $v0
		add $t4, $t4, $t1
		j build_hash_table_initializeValueGet
		
	build_hash_table_initializeValueGet:
		addi $t9, $sp, -104 # since calling function and key may touch the last 24 bits
		move $t6, $t9
	build_hash_table_getValue:
		move $a0, $t3
		move $a1, $t6
		li $a2, 1
		li $v0, 14
		syscall
		lb $t8, 0($t6)
		addi $t6, $t6, 1
		li $t7, 10
		beq $t8, $t7, build_hash_table_gotValue
		j build_hash_table_getValue
		
	build_hash_table_gotValue:
		li $t7, 0
		sb $t7, -1($t6)
		addi $sp, $sp, -24
		sw $t0, 4($sp)
		sw $t1, 8($sp)
		sw $t2, 12($sp)
		sw $t3, 16($sp)
		sw $t4, 20($sp)
		move $a0, $t9
		move $a1, $t1
		move $a2, $t2
		sw $ra, 0($sp)
		jal find_string
		lw $ra, 0($sp)
		lw $t0, 4($sp)
		lw $t1, 8($sp)
		lw $t2, 12($sp)
		lw $t3, 16($sp)
		lw $t4, 20($sp)
		addi $sp, $sp, 24
		move $t5, $v0
		add $t5, $t5, $t1
		j build_hash_table_putKeyValue
	
	build_hash_table_putKeyValue:
		addi $sp, $sp, -20
		sw $t0, 4($sp)
		sw $t1, 8($sp)
		sw $t2, 12($sp)
		sw $t3, 16($sp)
		move $a0, $t0
		move $a1, $t4
		move $a2, $t5
		sw $ra, 0($sp)
		jal put
		lw $ra, 0($sp)
		lw $t0, 4($sp)
		lw $t1, 8($sp)
		lw $t2, 12($sp)
		lw $t3, 16($sp)
		addi $sp, $sp, 20
		addi $s0, $s0, 1
		j build_hash_table_initiateKeyGet
	
	build_hash_table_noMoreRead:
		# close the file
		li $v0, 16
		move $a0, $t3
		syscall
		move $v0, $s0
		j build_hash_table_end
	
	build_hash_table_fileDoesntExist:
		li $v0, -1
		j build_hash_table_end
	
	build_hash_table_end:
		lw $s0, 0($sp)
		addi $sp, $sp, 4
		jr $ra

# t0: '1st argument' =hash_table
# t1: '2nd argument' =src & current string
# t2: '3rd argument' =dest
# t3: '4th argument' =strings
# t4: '5th argument' =strings_length
# t5: '6th argument' =filename
# t6: current character of src
# t7: TEMP
# t8: TEMP #2
# t9: address to hold key
autocorrect:
	# initialize the function
	# store arguments into $t registers
	move $t0, $a0
	move $t1, $a1
	move $t2, $a2
	move $t3, $a3
	lw $t4, 0($sp)
	lw $t5, 4($sp)
	addi $sp, $sp, -4
	li $s0, 0 # initialize return value
	# function call = build_hash_table
	addi $sp, $sp, -28
	sw $t0, 4($sp)
	sw $t1, 8($sp)
	sw $t2, 12($sp)
	sw $t3, 16($sp)
	sw $t4, 20($sp)
	sw $t5, 24($sp)
	move $a0, $t0
	move $a1, $t3
	move $a2, $t4
	move $a3, $t5
	sw $ra, 0($sp)
	jal build_hash_table
	lw $ra, 0($sp)
	lw $t0, 4($sp)
	lw $t1, 8($sp)
	lw $t2, 12($sp)
	lw $t3, 16($sp)
	lw $t4, 20($sp)
	lw $t5, 24($sp)
	addi $sp, $sp, 28
	
	# initalize values prior to loop
	autocorrect_initialize:
		addi $t9, $sp, -150 # area to hold key to put in
	# loop to convert src to dest
	autocorrect_storeCurrWord:
		lb $t6, 0($t1) # load current character of src
		beqz $t6, autocorrect_foundDelim
		beq $t6, 32, autocorrect_foundDelim
		beq $t6, 44, autocorrect_foundDelim
		beq $t6, 46, autocorrect_foundDelim
		beq $t6, 63, autocorrect_foundDelim
		beq $t6, 33, autocorrect_foundDelim
		sb $t6, 0($t9)
		addi $t9, $t9, 1
		addi $t1, $t1, 1
		j autocorrect_storeCurrWord
	
	autocorrect_foundDelim:
		li $t7, 0
		sb $t7, 0($t9) # insert null terminator for word
		addi $t1, $t1, 1
		addi $t9, $sp, -150 # go back to beginning of word
		# call get
		addi $sp, $sp, -36
		sw $t0, 4($sp)
		sw $t1, 8($sp)
		sw $t2, 12($sp)
		sw $t3, 16($sp)
		sw $t4, 20($sp)
		sw $t5, 24($sp)
		sw $t6, 28($sp)
		sw $t9, 32($sp)
		move $a0, $t0
		move $a1, $t9
		sw $ra, 0($sp)
		jal get
		lw $ra, 0($sp)
		lw $t0, 4($sp)
		lw $t1, 8($sp)
		lw $t2, 12($sp)
		lw $t3, 16($sp)
		lw $t4, 20($sp)
		lw $t5, 24($sp)
		lw $t6, 28($sp)
		lw $t9, 32($sp)
		addi $sp, $sp, 12
		# see if key exists
		beq $v0, -1, autocorrect_noKey
		j autocorrect_keyExistsGetValue
		
	autocorrect_noKey:
		lb $t7, 0($t9)
		beqz $t7, autocorrect_noKey_done
		sb $t7, 0($t2)
		addi $t9, $t9, 1
		addi $t2, $t2, 1
		j autocorrect_noKey
		autocorrect_noKey_done:
			sb $t6, 0($t2)
			addi $t2, $t2, 1
			beqz $t6, autocorrect_endOfSrc
			j autocorrect_initialize
			
	autocorrect_keyExistsGetValue:
		addi $s0, $s0, 1
		lw $t9, 0($t0) # current capacity of hash_table
		li $t8, 4
		mul $t7, $t9, $t8 # $t9 holds starting index of value
		mul $v0, $v0, $t8
		move $t9, $t0
		addi $t9, $t9, 8
		add $t9, $t9, $t7
		add $t9, $t9, $v0
		lw $t9, 0($t9)
		autocorrect_keyExistsGetValue_loop:
			lb $t7, 0($t9)
			beqz $t7, autocorrect_keyExistsGetValue_loop_done
			sb $t7, 0($t2)
			addi $t9, $t9, 1
			addi $t2, $t2, 1
			j autocorrect_keyExistsGetValue_loop
			autocorrect_keyExistsGetValue_loop_done:
				sb $t6, 0($t2)
				addi $t2, $t2, 1
				beqz $t6, autocorrect_endOfSrc
				j autocorrect_initialize
		
	autocorrect_endOfSrc:
		move $v0, $s0
		j autocorrect_end
	
	autocorrect_end:
		lw $s0, 0($sp)
		addi $sp, $sp, 4
		jr $ra

