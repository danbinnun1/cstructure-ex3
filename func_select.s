.section	.rodata

str1:	.string	"first pstring length: %d, second pstring length: %d\n"
str2:	.string	" %c %c"
str3:	.string	"old char: %c, new char: %c, first string: %s, second string: %s\n"
str4:	.string	"%hhu"
str5:	.string	"length: %d, string: %s\n"
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
	pushq	%rbp
	movq	%rsp,%rbp
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
	movq	%rbp,%rsp
	popq	%rbp
	ret
.L2:
	nop
.L3:
	pushq	%rbp
	movq	%rsp,%rbp
	leaq	-8(%rsp),%rsp
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
	pushq	%rsi		#caller saved register
	pushq	%rdx		#caller saved register
	call	replaceChar
	popq	%rdx		#restore caller saved register
	popq	%rsi		#restore caller saved register
	popq	%rdi		#set second pstring to first arg of replace char
	pushq	%rax		#save result of first string
	pushq	%rsi		#caller saved register
	pushq	%rdx		#caller saved register
	call 	replaceChar
	leaq	1(%rax),%r8	#set fifth arg of printf to second string result
	popq	%rdx		#restore caller saved register
	popq	%rsi		#restore caller saved register
	popq	%rax
	leaq	1(%rax),%rcx	#set fourth arg of printf to first string result
	movq	$str3,%rdi
	leaq	-8(%rsp),%rsp	#set rsp to be 16 align to call printf
	call	printf
	movq	%rbp,%rsp
	popq	%rbp
	ret
	
.L4:
	pushq	%rbp
	movq	%rsp,%rbp
	pushq	%rsi		#save first
	pushq	%rdx		#save second
	leaq	-16(%rsp),%rsp
	movq	$0,%rax
	movq	$str4,%rdi
	leaq	1(%rsp),%rsi	#scan i
	call	scanf
	movq	$0,%rax
	movq	$str4,%rdi
	movq	%rsp,%rsi	#scan j
	call 	scanf
	movzbq	1(%rsp),%rdx	#put i in third arg
	movzbq	(%rsp),%rcx	#put j in fourth arg
	leaq	16(%rsp),%rsp
	popq	%rsi		#put src in second arg
	popq	%rdi		#put dest in first arg
	pushq	%rsi		#save src
	leaq	-8(%rsp),%rsp
	call 	pstrijcpy
	movq	$str5,%rdi
	movzbq	(%rax),%rsi	#put dest length in second arg of printf
	leaq	1(%rax),%rdx	#put dest string pointer in third arg of printf
	movq	$0,%rax
	call	printf
	leaq	8(%rsp),%rsp
	popq	%rdx		#get src
	movq	$str5,%rdi
	movzbq	(%rdx),%rsi	#put src length in second arg of printf
	leaq	1(%rdx),%rdx	#put src string pointer in third arg of printf
	call	printf
	movq	%rbp,%rsp
	popq	%rbp
	ret
.L5:
	nop
.L6:
	ret
