; nasm -felf64 1.asm && gcc -no-pie 1.o && ./a.out < input.txt
section .data
	fmt dw "%d", 10, 0
	input db '0'
	vBuf times 14 db '0'
section .text
	global main
	extern printf
main:
	mov r8, 0	; counter
while:
	; input char
	mov eax, 3
	mov ebx, 0
	mov ecx, input
	mov edx, 1
	int 80h

	inc r8	; increment counter
	mov r9d, 0	; rotate index
	; store first 14 chars
	cmp r8, 14
	jg rotate
	mov spl, [input]
	mov [vBuf + r8 - 1], spl
	jmp while	
	
	; offset array by 1 after first 14 characters
rotate:
	mov spl, [1 + vBuf + r9d]
	mov [vBuf + r9d], spl
	inc r9d
	cmp r9d, 13
	jl rotate
	mov spl, [input]
	mov [vBuf + r9d], spl

	; repeat condition
	mov r10d, 0
outerLoop:
	mov spl, [vBuf + r10d]
	mov r11d, r10d
	inc r11d
innerLoop:
	cmp [vBuf + r11d], spl
	je while
	inc r11d
	cmp r11d, 13
	jle innerLoop
	inc r10d
	cmp r10d, 13
	jl outerLoop

terminate:
	; print counter value
	mov	eax, 0
	mov	rdi, fmt
	mov	rsi, r8
	call printf
	; exit
	mov eax, 1
	int 80h
