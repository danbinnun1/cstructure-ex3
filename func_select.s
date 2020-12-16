.section	.rodata

str1:	.string	"first pstring length: %d, second pstring length: %d\n"
str2:	.string	" %c %c"
str3:	.string	"old char: %c, new char: %c, first string: %s, second string: %s\n"
.align 8

.L10:
	.quad	.L1	#case 50
	.quad	.L2	#case 51
	.quad	.L3	#case 52
	.quad	.L4	#case 53
	.quad	.L5	#case 55
	.quad	.L2	#case 56
	.quad	.L2	#case 57
	.quad	.L2	#case 58
	.quad	.L2	#case 59
	.quad	.L1	#case 60

	.text
.globl	run_func
	.type	run_func, @function
run_func:
	leaq	-50(%rdi),%rdi
	cmpq	$10,%rdi
	ja	.L2
	jmp	*.L10(,%rdi,8)

.L1:
	movq	%rsi,%rdi	#set arg of pstrlen
	pushq	%rdx		#caller saved register
	call	pstrlen
	popq	%rdx
	movq	%rax,%rsi	#assign result to printf second arg

	movq	%rdx,%rdi
	pushq	%rsi		#caller saved register
	call	pstrlen
	popq	%rsi
	movq	%rax,%rdx

	movq	$str1,%rdi
	movq	$0,%rax
	call 	printf
	jmp	.L6
.L2:
	nop
.L3:
	pushq	%rdx		#save second str
	pushq	%rsi		#save first str
	leaq	-8(%rsp),%rsp	#allocate space for two characters
	movq	$str2,%rdi
	movq	$0,%rax
	movq	%rsp,%rsi	#set destination for new char
	leaq	1(%rsp),%rdx
	movq	$0,%rax
	call	scanf
	movzbq	1(%rsp),%rdx	#set old char arg
	movzbq	(%rsp),%rsi	#set new char arg
	leaq	8(%rsp),%rsp	#dealloacte chars memory
	popq	%rdi		#set first pstring to first arg of replace char
	pushq	%rsi
	pushq	%rdx
	call	replaceChar
	popq	%rdx
	popq	%rsi
	popq	%rdi
	pushq	%rax
	pushq	%rsi
	pushq	%rdx
	call 	replaceChar
	leaq	1(%rax),%r8
	popq	%rdx
	popq	%rsi
	popq	%rax
	leaq	1(%rax),%rcx
	movq	$str3,%rdi
	leaq	-8(%rsp),%rsp
	call	printf
	leaq	8(%rsp),%rsp
	ret
	
.L4:
	nop
.L5:
	nop
.L6:
	ret
