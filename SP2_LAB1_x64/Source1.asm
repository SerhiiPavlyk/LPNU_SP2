 printf proto c : vararg
 EXTERN K : WORD
 .data
 msg db 'Output from asm module is: %lld', 0
 .code
 calc PROC
 sub rsp, 20h
 xor rax, rax ; cleaning reg rax
 mov eax, ecx
 cdqe  ;register expansion from 4 bytes to 8
 mov rcx,rax ; move A to rcx 
 ;ecx - A
 ;dl - B
 ;r8w - D
 sar r8w, 1 ; div D to 2
 xor rax, rax ; cleaning reg rax
 mov ax, r8w ; move D/2 to ax
 cwde ;register expansion from 2 bytes to 4
 mov r8d, eax ; move D/2 to r8d
 xor rax, rax ; cleaning reg rax
 mov al, dl ; move B to al
 cbw ;register expansion from 1 bytes to 2
 mov dx, ax; move B to dx
 sal ax,2 ; mul B * 4  
 cwde ;register expansion from 2 bytes to 4
 mov ebx,eax ; move 4B to ebx
 sub r8d, ebx ; D/2 - 4B => r8d
 xor rax, rax ; cleaning reg rax
 add dx,K ; add K to B
 mov ax, dx ; move res of add to ax
 cwde ;register expansion from 2 bytes to 4
 mov edx, eax ; B + K => edx
 add edx, r8d ; (B + K) - (D/2 - 4B) => edx
 xor rax, rax ;cleaning reg rax
 mov eax, edx ; move calc (B + K) - (D/2 - 4B) to eax
 cdqe ; ;register expansion from 4 bytes to 8 (B + K) + (D/2 - 4B) => rax
 sub rcx, rax ; A - ( (B + K) + (D/2 - 4B) ) = > rcx

 mov rax, rcx
 mov rbx, rcx
 lea rcx, msg
 mov rdx, rax
 call printf
 mov rax, rbx
 add rsp, 20h
 ret
 calc ENDP
 END