	.section	.rodata
str1:	.string		"%hhu"
str2:	.string		"%s"
str3:	.string		"%d"
frmt1:	.string		"length is %hhu, str is %s\n"

	.text
.globl main
	.type main, @function
main:
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

	leaq	1(%rsp),%rsi
	movq	%rsi,%rdx
	movzbq	(%rsp),%rsi
	movq	$frmt1,%rdi
	movq	$0,%rax
	call	printf

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

	leaq	257(%rsp),%rdx
	movzbq	256(%rsp),%rsi
	movq	$frmt1,%rdi
	movq	$0,%rax
	call	printf

	subq	$16,%rsp
	movq	$str3,%rdi
	movq	%rsp,%rsi
	movq	$0,%rax
	call	scanf

	movq 	$0,%rax
	movq	%rbp,%rsp
	pop	%rbp
	ret
