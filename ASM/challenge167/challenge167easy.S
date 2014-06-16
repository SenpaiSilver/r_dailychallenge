; Easy Challenge 167: http://redd.it/289png
; Status: Aborted
;
;	Compile:
; $ nasm challenge167easy.S -f elf64 -o challenge167easy.o
; $ gcc challenge167easy.o -o challenge167easy
;
; Usage:
; ./challenge167easy <outputfile>

[BITS 64]

global	main

section	.rodata
	strStart:			db '<!DOCTYPE html>',0xA,'<html>',0xA,0x9,'<head>',0xA,0x9,0x9,'<title></title>',0xA,0x9,'</head>',0xA,0xA,0x9,'<body>',0xA,0x9,0x9,'<p>',0
	strStartLen:	equ $-strStart
	strEnd:				db '</p>',0xA,0x9,'</body>',0xA,'</html>',0
	strEndLen:		equ $-strEnd
	strUsage:			db 'Usage: ./challenge167easy <outputfile>',0xA,0
	strUsageLen:	equ $-strUsage
	strOpenError:			db "Can't open file.",0xA,0
	strOpenErrorLen:	equ $-strOpenError

section	.text

main:
	push	rbp
	mov		rbp,rsp
	sub		rsp,4096
	
	cmp		rdi,2
	jne		usage
	
	mov		r11,rsi

getstring:
	mov		rax,0
	mov		rdi,0
	mov		rsi,rsp
	mov		rdx,4096
	syscall
	cmp		rax,1
	jle		endmain

	mov		r10,rax
	sub		r10,1
openit:
	mov		rax,2
	mov		rdi,r11
	mov		rsi,2
	;mov		rsi,0102o
	;mov		rdx,0666o
	syscall
	mov		r12,rax
	cmp		rax,0
	jl		cantopen
	
writeit:
	mov		rax,1
	mov		rdi,r12
	mov		rsi,strStart
	mov		rdx,strStartLen
	syscall
	
	mov		rax,1
	mov		rdi,r12
	mov		rsi,rsp
	mov		rdx,r10
	syscall
	
	mov		rax,1
	mov		rdi,r12
	mov		rsi,strEnd
	mov		rdx,strEndLen
	syscall

closeit:
	mov		rax,3
	mov		rdi,r12
	syscall
endmain:
	add		rsp,4096
	mov		rsp,rbp
	pop		rbp
	ret
usage:
	mov		rax,1
	mov		rdi,2
	mov		rsi,strUsage
	mov		rdx,strUsageLen
	syscall
	jmp		endmain

cantopen:
	mov		rax,1
	mov		rdi,2
	mov		rsi,strOpenError
	mov		rdx,strOpenErrorLen
	syscall
	mov r12,1
	jmp		writeit