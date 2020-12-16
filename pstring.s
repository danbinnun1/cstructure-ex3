.section	.rodata

str1:	.string	"first pstring length: %d, second pstring length: %d\n"

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
.L3:
	cmpb	%sil,1(%rdi,%rcx,1)	#compare old char and current char
	addq	$1,%rcx
	jne	.L2
	movq	%dl,1(%rdi,%rcx,1)	#set new char if equals
.L2:	
	cmpq	%r8,%rcx
	jl	.L3
	movq	%rdi,%rax
	ret