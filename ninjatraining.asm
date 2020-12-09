extern  printf
extern scanf

section .data
	banner: db 10,"-- demon-i386 ninja training --",10,10,0
	msg: db "PID - %d | UID - %d | GID - %d",10,0
	getinpt: db "Digite um numero: ",0
	intr: times 4 db 0 
	formt: db "%d",0
	cu: db "%d",10,0
	outmsg: db "O numero escrito foi: %d", 10, 0
	mlt: db "A multiplicação do numero por 2 é: %d",10,0
section .text
global main
main:
	push ebp ; save ebp
	mov ebp, esp ; mover antigo topo da stack para o final
	sub esp, 100 ; incrementar 100 bytes na stack

	push banner
	call printf

	xor eax, eax ; eax = 0
	mov al, 24 ; getuid syscall
	int 0x80
	push eax ; retorno para stack

	xor eax, eax
	mov al, 20 ; getpid syscall
	int 0x80
	push eax

	xor eax, eax
	mov al, 47
	int 0x80
	push eax

	xor eax, eax
	push dword msg ; string "msg" para stack
	call printf
	add esp, 8 ; decrementar esp 

	xor eax, eax
	add esp, 8
	push getinpt
	call printf
	
	add esp, 4
	push intr
	push formt
	call scanf

	add esp, 8
	xor ebx, ebx

	mov ebx, [intr]
	push ebx
	push outmsg
	call printf

	add esp,8
	add ebx, ebx
	push ebx
	push cu
	call printf
	
	leave ; destroi a stack

	xor eax, eax
	xor ebx, ebx
	mov al, 1
	int 0x80 
