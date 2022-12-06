; nasm -felf64 1.asm && gcc -no-pie 1.o && ./a.out < input.txt
section .data
	v1 db '0'
	v2 db '0'
	v3 db '0'
	input db '0'
	fmt db "%d", 10, 0
section .text
	global main
	extern printf
main:
	mov r8, 0	; counter
while:
	; update last 3 values
	mov ch, [v2]
	mov [v1], ch
	mov ch, [v3]
	mov [v2], ch
	mov ch, [input]
	mov [v3], ch

	; input char
	mov eax, 3
	mov ebx, 0
	mov ecx, input
	mov edx, 1
	int 80h

	; increment counter
	inc r8

	; repeat condition
	cmp r8, 3
	jle while
	mov ch, [input]
	cmp ch, [v1]
	je while
	cmp ch, [v2]
	je while
	cmp ch, [v3]
	je while
	mov ch, [v3]
	cmp ch, [v1]
	je while
	cmp ch, [v2]
	je while
	mov ch, [v2]
	cmp ch, [v1]
	je while
terminate:
	; print counter value
	mov	eax, 0
	mov	rdi, fmt
	mov	rsi, r8
	call printf
	; exit
	mov eax, 1
	int 80h
