.data  
fin:  .asciiz "input_hw1.txt"
buffer: .space 256

Uzero: .asciiz "Zero"
Uone: .asciiz "One"
Utwo: .asciiz "Two"
Uthree: .asciiz "Three"
Ufour: .asciiz "Four"
Ufive: .asciiz "Five"
Usix: .asciiz "Six"
Useven: .asciiz "Seven"
Ueight: .asciiz "Eight"
Unine: .asciiz "Nine"

Lzero: .asciiz "zero"
Lone: .asciiz "one"
Ltwo: .asciiz "two"
Lthree: .asciiz "three"
Lfour: .asciiz "four"
Lfive: .asciiz "five"
Lsix: .asciiz "six"
Lseven: .asciiz "seven"
Leight: .asciiz "eight"
Lnine: .asciiz "nine"
.text
  
    li  $v0, 13          
    la  $a0, fin			#filename
    syscall				#call system for opening
    move $s0, $v0		#saving file descriptor at $s0
    
    
    li	$v0, 14			
    move $a0, $s0		#saving file descriptor
    la	$a1, buffer		#input buffer
    la	$a2, 256			#read max. 256 bytes.
    syscall				#call system for reading
    
    addi $s7,$s7,1		#string iterator adder
    
    
    li  $s1, ' '				#The character's second left character in 		$s1
    li  $s2, ' '				#The character's left character		in		$s2
    
    la	$t0,	buffer			#THE CHARACTER WE ARE CHEKING   	in 	$s3
    lb	$s3,	($t0)
    
    la  $t0,	buffer($s7)		#The character's right character			in	$s4
    lb  $s4,	($t0)
    
    addi $s7,$s7,1
    la  $t0,	buffer($s7)		#The character's second right character	in	$s5
    lb  $s5,	($t0)
    
    
    li  $t0, '0'
    IsNumber :
	beq $s3,$t0,IsRightnumber
	beq $t0,'9',NoConvert
 	addi $t0,$t0,1
 	j IsNumber
 	
    IsRightnumber :
    	li $t0, '0'
    	checkingnum :
    		beq $s4,$t0,NoConvert
    		beq $t0,'9',IsRightDot
    		addi $t0,$t0,1
    		j checkingnum
		
    IsRightDot :
    	li $t0, '.'
	checkingdot :
    		beq $s4,$t0,IsSecondRightNumber
		j IsLeftNumber
    		
    		
    IsSecondRightNumber :
	li $t0, '0'
    	checkingsecondnum :
    		beq $s5,$t0,NoConvert
    		beq $t0,'9',IsLeftNumber
    		addi $t0,$t0,1
    		j checkingsecondnum
    		
    		
    IsLeftNumber :
    	li $t0, '0'
    	checkingleftnum :
    		beq $s2,$t0,NoConvert
    		beq $t0,'9',IsLeftDot
    		addi $t0,$t0,1
    		j checkingleftnum
    		
    IsLeftDot :
    	li $t0, '.'
    	beq $s2,$t0,NoConvert
    	j IsSecondLeftDot

    IsSecondLeftDot :
    	li $t0, '.'
    	beq $s1,$t0,UpperCaseConvert
	li $t0, ' '
    	beq $s1,$t0,UpperCaseConvert
    	j LowerCaseConvert
    	j final
    		
    NoConvert :
     	li $v0, 11
   	la	$a0,	($s3)
	syscall
	final :
		#updating variables for checking next character
		la $s1,($s2)
		la $s2,($s3)
		la $s3,($s4)
		la $s4,($s5)
		addi $s7,$s7,1
  	 	la  $t0,	buffer($s7)		
  	 	lb  $s5,	($t0)
  	 	li $t0,'0'
   		#finished updating
  	 	beq $s3, '\0', exit		#If EOF then exit
		j IsNumber
	
    UpperCaseConvert:
    	beq $s3,'0',Upzero
    	beq $s3,'1',Upone
    	beq $s3,'2',Uptwo
    	beq $s3,'3',Upthree
    	beq $s3,'4',Upfour
    	beq $s3,'5',Upfive
    	beq $s3,'6',Upsix
    	beq $s3,'7',Upseven
    	beq $s3,'8',Upeight
    	jal Upnine
    	j final
	
    LowerCaseConvert:
    	beq $s3,'0',Lozero
    	beq $s3,'1',Loone
    	beq $s3,'2',Lotwo
    	beq $s3,'3',Lothree
    	beq $s3,'4',Lofour
    	beq $s3,'5',Lofive
    	beq $s3,'6',Losix
    	beq $s3,'7',Loseven
    	beq $s3,'8',Loeight
    	jal Lonine
    	j final

    Upzero :
    	li $v0, 4
	la $a0, Uzero
	syscall
	j final

    Upone :
    	li $v0, 4
	la $a0, Uone
	syscall
	j final

    Uptwo :
    	li $v0, 4
	la $a0, Utwo
	syscall
	j final

    Upthree :
    	li $v0, 4
	la $a0, Uthree
	syscall
	j final

    Upfour :
    	li $v0, 4
	la $a0, Ufour
	syscall
	j final

    Upfive :
    	li $v0, 4
	la $a0, Ufive
	syscall
	j final

    Upsix :
    	li $v0, 4
	la $a0, Usix
	syscall
	j final

    Upseven :
    	li $v0, 4
	la $a0, Useven
	syscall
	j final

    Upeight :
    	li $v0, 4
	la $a0, Ueight
	syscall
	j final

    Upnine :
    	li $v0, 4
	la $a0, Unine
	syscall
	jr $ra

    Lozero :
    	li $v0, 4
	la $a0, Lzero
	syscall
	j final

    Loone :
    	li $v0, 4
	la $a0, Lone
	syscall
	j final

    Lotwo :
    	li $v0, 4
	la $a0, Ltwo
	syscall
	j final

    Lothree :
    	li $v0, 4
	la $a0, Lthree
	syscall
	j final

    Lofour :
    	li $v0, 4
	la $a0, Lfour
	syscall
	j final

    Lofive :
    	li $v0, 4
	la $a0, Lfive
	syscall
	j final

    Losix :
    	li $v0, 4
	la $a0, Lsix
	syscall
	j final

    Loseven :
    	li $v0, 4
	la $a0, Lseven
	syscall
	j final

    Loeight :
    	li $v0, 4
	la $a0, Leight
	syscall
	j final

    Lonine :
    	li $v0, 4
	la $a0, Lnine
	syscall
	jr $ra

	exit:
  		li	$v0, 16
  		move $a0, $s0		#carrying the file descriptor to the $a0 to close
  		syscall				#closing the file
