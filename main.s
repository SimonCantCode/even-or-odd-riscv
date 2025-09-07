.data
.align 2	 # I dont fully understand aligns, i had balign 8 before
buff:		 .space 8 # How many characters the number can be including a newline
prompt:		 .ascii "Enter a number: "
even_str:	 .ascii "Number is even.\n"
odd_str:	 .ascii "Number is odd.\n"
invalid_str: .ascii "Invalid input.\n"
#char_buf:	 .byte 0

.text 
.global main # _start would require initializing gp and other stuff a small boy like me doesnt understand >~<
main:
	# print syscall for the prompt
	addi a7, zero, 64
	addi a0, zero, 1 #stdout
	la	 a1, prompt
	addi a2, zero, 16
	ecall

	# Read syscall
	addi a7, x0, 63
	addi a0, x0, 0
	la	 a1, buff
	addi a2, x0, 8
	ecall

	# Convert numbers from ascii to int
	addi s1, x0, 0 # this will later be our answer
	loop: # loop throug each character untill newline
	#load byte from dereferenced pointer to a1
	lb	 t0, 0(a1) # a1 gets incremented in the end

	# break if newline
	addi t4, x0, 0x0A
	beq	 t0, t4, break
	
	# move each decimal to the left each itteration
	addi t4, x0, 10
	mul	 s1, s1, t4

	# if invalid number
	addi t4, x0, 0x30
	blt	 t0, t4, invalid # break if t0 < 0x30
	addi t4, x0, 0x3A 
	bge	 t0, t4, invalid # break if t0 >= 0x3A since there was no way to have it strictly >

	# Subtract 0x30 to convert from ascii char to number
	addi t0, t0, -0x30	
	add	 s1, s1, t0

	addi a1, a1, 1 # increment "offset" by 1 byte
	j loop
	break:

	# debug stuff, just kept the comments as a memory <3
	#store t0 in char_buff so i can print it
	#	la t1, char_buf   # load address of char_buf into register t1
	#	sb t0, 0(t1)      # store byte from t0 into memory at address in t1 + 0 offset

	addi t4, x0, 2
	rem	 t4, s1, t4 # t4 = s1 % 2, t4=0 if even, else odd
	beq	 t4, x0, even # if t4 == 0: goto even
	
	# if odd
	addi a7, zero, 64
	addi a0, zero, 1 #stdout
	la	 a1, odd_str
	addi a2, zero, 15
	ecall
	j end # as to not run label even

	even:
	# prints even
	addi a7, zero, 64
	addi a0, zero, 1 #stdout
	la	 a1, even_str
	addi a2, zero, 16
	ecall

	end:
	# exit syscall
	addi a7, zero, 93
	addi a0, zero, 69
	ecall

	# These gotos really make it feel like spaghetti 
	# but idk how else im supposed to do it lol
	invalid: 
	addi a7, zero, 64
	addi a0, zero, 1 #stdout
	la	 a1, invalid_str
	addi a2, zero, 15
	ecall
	j end




