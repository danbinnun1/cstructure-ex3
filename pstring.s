.section	.rodata

str1:	.string	"invalid input\n"

	.text
.globl	pstrlen
	.type	pstrem,		@function
pstrlen:
	movzbq	(%rdi),%rax
	ret

.globl	replaceChar
	.type	replaceChar,	@function
replaceChar:
	movzbq	(%rdi),%r8		#save length of str
	movq	$0,%rcx			#set counter to zero
	jmp	.L2			#check for-loop condition
.L3:
	cmpb	%sil,1(%rdi,%rcx,1)	#compare old char and current char
	jne	.L7
	movb	%dl,1(%rdi,%rcx,1)	#set new char if equals
.L7:
	addq	$1,%rcx			#increment loop counter
.L2:	
	cmpq	%r8,%rcx
	jl	.L3
	movq	%rdi,%rax
	ret

.globl	pstrijcpy
	.type	pstrijcpy,	@function
pstrijcpy:
	cmpb	(%rdi),%dl	#check if index are out of strings borders
	ja	.L6
	cmpb	(%rdi),%cl
	ja	.L6
	cmpb	(%rsi),%dl
	ja	.L6
	cmpb	(%rsi),%dl
	ja	.L6
	jmp	.L4
.L5:
	movzbq	%dl,%rdx		#load loop index
	movb	1(%rsi,%rdx,1),%al	#load i-th char of src
	movb	%al,1(%rdi,%rdx,1)	#set i-th charof dest
	addb	$1,%dl
.L4:
	cmpb	%dl,%cl			#loop condition
	jae	.L5
	movq	%rdi,%rax
	ret
.L6:
	leaq	-16(%rsp),%rsp
	movq	%rdi,(%rsp)
	movq	$str1,%rdi
	movq	$0,%rax
	call 	printf
	movq	(%rsp),%rax
	leaq	16(%rsp),%rsp
	ret

.globl  swapCase
        .type   swapCase,	@function
swapCase:
	movzbq	(%rdi),%rsi
	movq	$0,%rdx
.L9:
	cmpb	$97,1(%rdi,%rdx,1)	#check if below 'a'
	jb	.L10
	cmpb	$122,1(%rdi,%rdx,1)	#check if above 'z'
	ja	.L10
	movb	1(%rdi,%rdx,1),%cl
	subb	$32,%cl			#substract 32 to capitalize letter
	movb	%cl,1(%rdi,%rdx,1)
	jmp	.L8

.L10:
	cmpb    $65,1(%rdi,%rdx,1)      #check if below 'a'
        jb      .L8
        cmpb    $90,1(%rdi,%rdx,1)     #check if above 'z'
        ja      .L8
        movb    1(%rdi,%rdx,1),%cl
        addb    $32,%cl                 #substract 32 to capitalize letter
        movb    %cl,1(%rdi,%rdx,1)
.L8:
	addq	$1,%rdx
	cmpq	%rsi,%rdx
	jb	.L9
	movq	%rdi,%rax
	ret


