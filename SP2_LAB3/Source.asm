.686 ; для процесора не нижче INTEL-686
.model flat, c, STDCALL ; компілювати як програму для WIN32
option casemap : none ; код чутливий до регістру літер
GetFullPathNameA proto STDCALL, lpBuffer : DWORD, MAX_PATH : DWORD, LPCSTR : DWORD, lpFilePart: DWORD
MessageBoxA proto STDCALL, h : DWORD, lpText : DWORD, LPCSTR : DWORD, UINT : DWORD
ExitProcess proto STDCALL, uExitCode : DWORD
wsprintfA PROTO C : VARARG 
.data; вміст сегменту даних:
mtitle db ' Лабораторна робота №3 ', 0
message db 'FullPath: %s',0
buflen dd 256
i dd 256
Path db "Name.txt"; адреса файлу
ResBuff db 256 dup (0); буфер де зберігається повного шлях
messagebuf db 256 dup(0); буфер в якому збергірається повідомлення повністю

.code
start:
push 0; 4-й параметр: Покажчик на буфер, який отримує адресу кінцевого компонента імені файлу в шляху.
push offset ResBuff; 3-й параметр: Покажчик на буфер, який отримує рядок із закінченням нуля для диска та шляху.
push buflen; 2-й параметр: Розмір буфера для отримання рядка
push offset Path; 1-й параметр: Ім'я файлу.
call GetFullPathNameA; виклик функції API
mov edx, sizeof Path+1
L:
mov ecx, i 
mov al, ResBuff([ecx])
cmp eax,0
jnz NEXT
sub i, 1
loop L
NEXT:
mov ResBuff([ecx]), 0
sub i, 1
sub edx, 1
cmp edx, 0
jnz L

push offset ResBuff
push offset message
push offset messagebuf
call wsprintfA

; формування параметрів вікна для відображення результату
push 40h; стиль вікна - одна кнопка "OK"
; з піктограмою "і"
push offset mtitle; адреса рядка із заголовком 
push offset messagebuf; адреса рядка з повідомленням 
push 0; хендл програми-власника вікна
call MessageBoxA; виклик функції API
push 0; код виходу з програми
call ExitProcess; завершення програми
end start; закінчення сегменту коду
