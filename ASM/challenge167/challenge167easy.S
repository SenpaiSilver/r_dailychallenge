; Easy Challenge 167: http://redd.it/289png
;
; $ nasm challenge167easy.S -f elf64 -o challenge167easy.o
; $ gcc challenge167easy.o -o challenge167easy
; nasm challenge167easy.S -f elf64 -o challenge167.o && gcc challenge167.o -o challenge167.exe && ./challenge167.exe || clear && cat challenge167.exe.stackdump


[BITS 64]

global	main

section	.data
	strStart:			db '<!DOCTYPE html>\n<html>\n\t<head>\n\t\t<title></title>\n\t</head>\n\n\t<body>\n\t\t<p>',0
	strEnd:				db '</p>\n\t</body>\n</html>',0
	strUsage:			db 'Usage: ./challenge167easy <paragraph text>\n',0
	strStartLen:	equ $-strStart
	strEndLen:		equ $-strEnd
	strUsageLen:	equ $-strUsage

section	.text

main:
	push	rbp
	mov		rbp,rsp
	sub		rsp,0
	
	;mov		rcx,[rbp + 16]
	;cmp		byte [rbp],2
	;jne		usage
	jmp			usage
	
	add		rsp,0
	mov		rsp,rbp
	pop		rbp

	;ret

usage:
	mov		rax,1
	mov		rdi,1
	mov		rsi,strUsage
	mov		rdx,strUsageLen
	syscall
	ret