GetFullPathNameA proto 
MessageBoxA proto 
wsprintfA proto
.data 
mtitle db ' ����������� ������ �3 ', 0
message db 'FullPath: %s',0
buflen dd 256
i dq 256;68
Path db "This"; ������ �����
ResBuff db 256 dup (0); ����� �� ���������� ������� ����
messagebuf db 256 dup(0); ����� � ����� ����������
;����������� �������
.code 
mainCRTStartup proc 
sub rsp, 28h
; ���������� ��������� ��� ������� ������ �������
mov r9, 0; 4-� ��������: �������� �� �����, ���� ������ ������
;�������� ���������� ���� ����� � �����.
lea r8, ResBuff; 3-� ��������: �������� �� �����, ���� ������
;����� �� ���������� ���� ��� ����� �� �����.
lea rdx, buflen; 2-� ��������: ����� ������ ��� ��������� �����
lea rcx, Path; 1-� ��������: ��'� �����.
call GetFullPathNameA; ������ ������� API
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

lea r8, ResBuff; 3-� ��������: �������� �� �����, ���� ������ 
;��������� ������ API �������  GetFullPathNameA
lea rdx, message; 2-� ��������: �������� ����� 'FullPath: '
lea rcx, messagebuf; 1-� ��������: ����� ����������
call wsprintfA

; ���������� ��������� ���� ��� ����������� ����������
mov r9, 40h ; ����� ���� - ���� ������ "OK" � ���������� "�"
lea r8, mtitle ; ������ ����� �� ����������
lea rdx, messagebuf ; ������ ����� � ������������
mov rcx, 0 ; ����� ��������-�������� ����
call MessageBoxA ; ������ ������� API
add rsp, 28h
ret
mainCRTStartup endp 
end
GetFullPathNameA proto 
MessageBoxA proto 
wsprintfA proto
.data 
mtitle db ' ����������� ������ �3 ', 0
message db 'FullPath: %s',0
buflen dd 256
i dq 256;68
Path db "This"; ������ �����
ResBuff db 256 dup (0); ����� �� ���������� ������� ����
messagebuf db 256 dup(0); ����� � ����� ����������
;����������� �������
.code 
mainCRTStartup proc 
sub rsp, 28h
; ���������� ��������� ��� ������� ������ �������
mov r9, 0; 4-� ��������: �������� �� �����, ���� ������ ������
;�������� ���������� ���� ����� � �����.
lea r8, ResBuff; 3-� ��������: �������� �� �����, ���� ������
;����� �� ���������� ���� ��� ����� �� �����.
lea rdx, buflen; 2-� ��������: ����� ������ ��� ��������� �����
lea rcx, Path; 1-� ��������: ��'� �����.
call GetFullPathNameA; ������ ������� API
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

lea r8, ResBuff; 3-� ��������: �������� �� �����, ���� ������ 
;��������� ������ API �������  GetFullPathNameA
lea rdx, message; 2-� ��������: �������� ����� 'FullPath: '
lea rcx, messagebuf; 1-� ��������: ����� ����������
call wsprintfA

; ���������� ��������� ���� ��� ����������� ����������
mov r9, 40h ; ����� ���� - ���� ������ "OK" � ���������� "�"
lea r8, mtitle ; ������ ����� �� ����������
lea rdx, messagebuf ; ������ ����� � ������������
mov rcx, 0 ; ����� ��������-�������� ����
call MessageBoxA ; ������ ������� API
add rsp, 28h
ret
mainCRTStartup endp 
end
