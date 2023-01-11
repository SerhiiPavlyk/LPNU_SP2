.686 ; ��� ��������� �� ����� INTEL-686
.model flat, c, STDCALL ; ���������� �� �������� ��� WIN32
option casemap : none ; ��� �������� �� ������� ����
GetFullPathNameA proto STDCALL, lpBuffer : DWORD, MAX_PATH : DWORD, LPCSTR : DWORD, lpFilePart: DWORD
MessageBoxA proto STDCALL, h : DWORD, lpText : DWORD, LPCSTR : DWORD, UINT : DWORD
ExitProcess proto STDCALL, uExitCode : DWORD
wsprintfA PROTO C : VARARG 
.data; ���� �������� �����:
mtitle db ' ����������� ������ �3 ', 0
message db 'FullPath: %s',0
buflen dd 256
i dd 256
Path db "Name.txt"; ������ �����
ResBuff db 256 dup (0); ����� �� ���������� ������� ����
messagebuf db 256 dup(0); ����� � ����� ����������� ����������� �������

.code
start:
push 0; 4-� ��������: �������� �� �����, ���� ������ ������ �������� ���������� ���� ����� � �����.
push offset ResBuff; 3-� ��������: �������� �� �����, ���� ������ ����� �� ���������� ���� ��� ����� �� �����.
push buflen; 2-� ��������: ����� ������ ��� ��������� �����
push offset Path; 1-� ��������: ��'� �����.
call GetFullPathNameA; ������ ������� API
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

; ���������� ��������� ���� ��� ����������� ����������
push 40h; ����� ���� - ���� ������ "OK"
; � ���������� "�"
push offset mtitle; ������ ����� �� ���������� 
push offset messagebuf; ������ ����� � ������������ 
push 0; ����� ��������-�������� ����
call MessageBoxA; ������ ������� API
push 0; ��� ������ � ��������
call ExitProcess; ���������� ��������
end start; ��������� �������� ����
