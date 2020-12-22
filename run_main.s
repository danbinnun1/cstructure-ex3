#	214289415 dan binnun
	.section	.rodata
str1:	.string		"%hhu"
str2:	.string		"%s"
str3:	.string		"%d"

	.text
.globl run_main
	.type run_main, @function
run_main:
	pushq	%rbp
	movq	%rsp,%rbp 		#setup

	leaq	-512(%rsp),%rsp		#allocate space for two pstrings
	movq	$0,%rax		
	movq	$str1,%rdi		#set scanf arguement
	movq	%rsp,%rsi		#set scanf destination to first byte of second pstring
	call	scanf
	movq	$str2,%rdi
	leaq	1(%rsp),%rsi		#set scanf destination to second byte of pstring (first is length)
	movq	$0,%rax
	call	scanf			#read string content
	movzbq	(%rsp),%rcx
	movb	$0,1(%rsp,%rcx,1)	#set null termination

	movq	$str1,%rdi
	leaq	256(%rsp),%rsi
	movq	$0,%rax
	call	scanf
	movq	$str2,%rdi
	leaq	257(%rsp),%rsi
	movq	$0,%rax
	call	scanf
	movzbq	256(%rsp),%rcx
	movb	$0,257(%rsp,%rcx,1)

	subq	$16,%rsp
	movq	$str3,%rdi
	movq	%rsp,%rsi
	movq	$0,%rax
	call	scanf

	movl	(%rsp),%edi
	addq	$16,%rsp

	movq	%rsp,%rsi
	leaq	256(%rsp),%rdx
	call	run_func
	movq	%rbp,%rsp
	pop	%rbp
	ret
