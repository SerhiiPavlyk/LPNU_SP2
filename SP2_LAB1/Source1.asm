.686
.model flat, c
printf proto c : vararg
EXTERN K : WORD
.data
msg db 'Output from asm module is: %d', 0
.code
calc PROC
push ebp
mov ebp, esp
xor edx, edx ; cleaning reg edx
mov dl, byte ptr[ebp + 12]; move B to dl
xor ecx, ecx ; cleaning reg ecx
mov cx, word ptr[ebp+16] ; move D to cx
sar cx, 1 ; div cx using sar
xor eax, eax ; cleaning reg eax
mov ax, cx ; move cx to ax
cwde ; register expansion from two bytes to four
mov ecx, eax ; move D/2 to ecx
xor eax, eax ; cleaning reg eax
mov al, dl ; move dl to al
cbw ; register expansion from one bytes to two
xor ebx, ebx ; cleaning reg ebx
mov bx, ax ; move B to bx
mov dx, ax ; move copy of B to dx
sal ax,2  ; mul B to 4 using sal
cwde ;register expansion from two bytes to four
mov ebx, eax ;move 4*B to ebx
sub ecx, ebx ; D/2 - 4B => ecx
xor eax, eax ; cleaning reg eax
add dx,K ;add const K to B
mov ax, dx; move res of add to ax
cwde ;register expansion from two bytes to four
mov edx, eax ; B + K => edx
add edx, ecx ; (B + K) - (D/2 - 4B) => edx
xor eax, eax ; cleaning reg ebx
mov eax, dword ptr[ebp + 8] ; move A to eax
sub eax, edx ; sub from A res of calc (B + K) - (D/2 - 4B)
pop ebp
push eax
invoke printf, offset msg, eax
pop eax
ret
calc ENDP
END
