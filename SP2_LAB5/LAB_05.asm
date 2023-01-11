.686
.model flat, stdcall
option casemap:none
include    C:\masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\user32.inc
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\user32.lib
include C:\masm32\include\msvcrt.inc
includelib C:\masm32\lib\msvcrt.lib
.data
LibName		 db "SP2_LAB5_DLL.dll",0
FunctionName db "RemoveMiddleLetter",0
DllNotFound  db "Cannot load library",0
AppName		 db "Load Library",0
NotFound	 db "RemoveMiddleLetter function not found",0
;
hConsoleInput  dd 0		;console descriptor for input
hConsoleOutput dd 0		;console descriptor for output

Message db 'Enter text:', 10, 13
NumberOfChToWMessage dd $-Message

ReadBuf db 1024 dup(?)	;buffer for entered characters

NumberOfChars dd 0		;Number of input/output characters
NumberOfCharsS dd 0 

.data?
hLib dd ?
RemoveMiddleLetter dd ?


.code
start:
invoke GetStdHandle, -11
mov hConsoleOutput, eax
invoke WriteConsoleA, hConsoleOutput, addr Message, NumberOfChToWMessage, addr NumberOfChars, 0

invoke GetStdHandle, -10
mov hConsoleInput, eax
invoke ReadConsoleA, hConsoleInput, addr ReadBuf, 1024, addr NumberOfChars, 0

invoke LoadLibrary,addr LibName ; завантаження бібліотеки
	.if eax == NULL ; якщо завантаження не вдалося
		invoke MessageBox,NULL,addr DllNotFound,addr AppName,MB_OK
	.else
		mov hLib,eax ; збереження заголовку бібліотеки
		; визначення адреси функції
		invoke GetProcAddress,hLib,addr FunctionName
		.if eax == NULL ; якщо не вдалося взяти адресу
			invoke MessageBox,NULL,addr NotFound,addr AppName,MB_OK
		.else
			push offset ReadBuf
			mov RemoveMiddleLetter,eax 
			call [RemoveMiddleLetter] ; виклик функції
		.endif
		invoke FreeLibrary,hLib ; вивантаження бібліотеки
	.endif
invoke ExitProcess, 0
end start