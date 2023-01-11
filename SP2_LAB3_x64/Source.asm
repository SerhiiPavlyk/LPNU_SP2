GetFullPathNameA proto 
MessageBoxA proto 
wsprintfA proto
.data 
mtitle db ' Лабораторна робота №3 ', 0
message db 'FullPath: %s',0
buflen dd 256
i dq 256;68
Path db "This"; адреса файлу
ResBuff db 256 dup (0); буфер де зберігається повного шлях
messagebuf db 256 dup(0); буфер в якому зберігається
;повідомлення повністю
.code 
mainCRTStartup proc 
sub rsp, 28h
; формування параметрів для виклику заданої функції
mov r9, 0; 4-й параметр: Покажчик на буфер, який отримує адресу
;кінцевого компонента імені файлу в шляху.
lea r8, ResBuff; 3-й параметр: Покажчик на буфер, який отримує
;рядок із закінченням нуля для диска та шляху.
lea rdx, buflen; 2-й параметр: Розмір буфера для отримання рядка
lea rcx, Path; 1-й параметр: Ім'я файлу.
call GetFullPathNameA; виклик функції API
mov rdx, sizeof Path+1
L:
mov rcx, i 
mov al, [ResBuff+rcx]
cmp rax,0
jnz NEXT
sub i, 1
loop L
NEXT:
mov [ResBuff+rcx], 0
sub i, 1
sub rdx, 1
cmp rdx, 0
jnz L

lea r8, ResBuff; 3-й параметр: Покажчик на буфер, який зберігає 
;результат роботи API функції  GetFullPathNameA
lea rdx, message; 2-й параметр: передача Фрази 'FullPath: '
lea rcx, messagebuf; 1-й параметр: Запис результату
call wsprintfA

; формування параметрів вікна для відображення результату
mov r9, 40h ; стиль вікна - одна кнопка "OK" з піктограмою "і"
lea r8, mtitle ; адреса рядка із заголовком
lea rdx, messagebuf ; адреса рядка з повідомленням
mov rcx, 0 ; хендл програми-власника вікна
call MessageBoxA ; виклик функції API
add rsp, 28h
ret
mainCRTStartup endp 
end
GetFullPathNameA proto 
MessageBoxA proto 
wsprintfA proto
.data 
mtitle db ' Лабораторна робота №3 ', 0
message db 'FullPath: %s',0
buflen dd 256
i dq 256;68
Path db "This"; адреса файлу
ResBuff db 256 dup (0); буфер де зберігається повного шлях
messagebuf db 256 dup(0); буфер в якому зберігається
;повідомлення повністю
.code 
mainCRTStartup proc 
sub rsp, 28h
; формування параметрів для виклику заданої функції
mov r9, 0; 4-й параметр: Покажчик на буфер, який отримує адресу
;кінцевого компонента імені файлу в шляху.
lea r8, ResBuff; 3-й параметр: Покажчик на буфер, який отримує
;рядок із закінченням нуля для диска та шляху.
lea rdx, buflen; 2-й параметр: Розмір буфера для отримання рядка
lea rcx, Path; 1-й параметр: Ім'я файлу.
call GetFullPathNameA; виклик функції API
mov rdx, sizeof Path+1
L:
mov rcx, i 
mov al, [ResBuff+rcx]
cmp rax,0
jnz NEXT
sub i, 1
loop L
NEXT:
mov [ResBuff+rcx], 0
sub i, 1
sub rdx, 1
cmp rdx, 0
jnz L

lea r8, ResBuff; 3-й параметр: Покажчик на буфер, який зберігає 
;результат роботи API функції  GetFullPathNameA
lea rdx, message; 2-й параметр: передача Фрази 'FullPath: '
lea rcx, messagebuf; 1-й параметр: Запис результату
call wsprintfA

; формування параметрів вікна для відображення результату
mov r9, 40h ; стиль вікна - одна кнопка "OK" з піктограмою "і"
lea r8, mtitle ; адреса рядка із заголовком
lea rdx, messagebuf ; адреса рядка з повідомленням
mov rcx, 0 ; хендл програми-власника вікна
call MessageBoxA ; виклик функції API
add rsp, 28h
ret
mainCRTStartup endp 
end
