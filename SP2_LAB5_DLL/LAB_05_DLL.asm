include C:\masm32\include\masm32rt.inc

.data
tit db "Lab 5, ASM DLL function", 0

TextRealSize dd 0 ; ������ ������� ��� ����������
;ReadBuf db 1024 dup(?)	; ����� � ����� ����������� �� ������ ������������ �������
i dd 0; ��� ������ � ������
middle_pos dd 0 ; ������� ���������� �������
Format	db 'Result', 0; ���� ��� ������ �����
Result	db	1024 dup (0), 10, 13 ; ��������� ������ ��������
WordRealSize dd 0 ;������ ������� ����������� ����� ������
Word_size_mod2 dd 0 ;���������� �������� ����������� ������� �� ������ 2
Text_word	db	512 dup (0), 10, 13 ; ���� �����
temperary_word db 512 dup (0), 10, 13 ; �������� ���� �����
temp_word_size dd 0 ; ����� ���������� �����
word_pointer dd 0 ; ��� ������ � ��������� �����
res_pointer dd 0 ; ��� ������ � ��������� ����������

ReadBuf Db 512 dup(0)
lenstr dd 0

lastChar dd 0
.code
;-------------------- �������� ������� --------------------------
DllEntry PROC hInstDLL:DWORD, reason:DWORD, reserved:DWORD
mov eax, 1
ret
DllEntry ENDP
;-------------------- ������� � �������� ----------------------

RemoveMiddleLetter PROC ReadBu:DWORD

PUSH ReadBu
call StrLen
mov lenstr, eax
mov ecx, 0
.while ecx < lenstr
  mov eax, ReadBu
  add eax, ecx
  mov eax, [eax]
  mov byte ptr [ReadBuf+ecx], al
  inc ecx
.endw

mov edx, lastChar 
L:
mov al, ReadBuf([edx])
cmp eax, 0
je NEXT
add edx, 1
loop L
NEXT:
mov lastChar, edx
mov TextRealSize, edx

f:
mov edx, i ;������������ ��������� ����� � ������ edx
cmp TextRealSize, edx ; ��������� ��������� ����� � ������� ������
jl f_end ;  i < size ; ���� �������� ��������� ����� �� �����, �������� � �����

;�������� �� ���������
.if (ReadBuf[edx] == 46 || ReadBuf[edx] == 59 || ReadBuf[edx] == 44 || ReadBuf[edx] == 32 || ReadBuf[edx] == 13)

;dividerComma     ','  2C = 44
;dividerDot       '.'  2E = 46
;dividerSpace     ' '  20 = 32
;dividerSemicolon ';'  3B = 59
;dividerEnd       '\0' 3B = 59

; ��������� ������ �����
mov ebx, 0; ������������ � ������ ��������� �����, ���� ��������
w_size:
mov al, Text_word[ebx]
cmp eax, 0
je w_end
add ebx, 1
loop w_size
w_end:
mov WordRealSize, ebx

mov edx, WordRealSize
mov Word_size_mod2, edx
AND Word_size_mod2, 1 ; % 2

; ���������� ��������� � ������
mov edx, i

; ���� ������� ����� ����� 1 � ����� �� ������� ������� ����, �� ��������� �������
.if (Word_size_mod2!= 0 && WordRealSize > 1)
mov eax, WordRealSize

sar eax, 1 ; ��������� ������� �������� �����
mov middle_pos, eax
mov ebx, 0
f_2:
cmp WordRealSize, ebx
jl f_2_end ; j < WordSize
xor eax, eax
mov al, Text_word[ebx]
.if (ebx > middle_pos)
mov temperary_word[ebx-1], al
.endif
.if (ebx<middle_pos)
mov temperary_word[ebx], al
.endif
add ebx, 1; j++
loop f_2
f_2_end:

mov ebx, 0
f_3_calc_size_temp:
xor eax, eax
mov al, temperary_word[ebx]
cmp eax, 0
je f_3_calc_size_temp_end
add ebx, 1
loop f_3_calc_size_temp
f_3_calc_size_temp_end:
mov temp_word_size, ebx
 

mov ebx, 0


;free reg 
mov i, edx


f_3_temp_to_res:
cmp temp_word_size, ebx
jl f_3_temp_to_res_end ; k < temp_word_size
xor eax, eax
mov eax, res_pointer
add eax, ebx  ;; to eax add ebx
xor edx, edx
mov dl, temperary_word[ebx]
mov Result[eax],dl
inc ebx
.if (ebx == temp_word_size)
add res_pointer, ebx ;;;res_pointer = res_pointer + k+1;
.endif

;inc ebx ������ �����, �� ��� �� ����� ������ ebx +1
loop f_3_temp_to_res
f_3_temp_to_res_end:

mov edx, i
mov ebx, res_pointer
xor eax, eax
mov al, ReadBuf[edx]
mov Result[ebx], al
inc res_pointer

mov ebx, 0
f_clear_word:
cmp WordRealSize, ebx
jl f_clear_word_end ; j < WordSize

mov Text_word[ebx], 0

inc ebx
loop f_clear_word
f_clear_word_end:

mov word_pointer,0



.if (ReadBuf[edx + 1] == 32)
mov ebx, res_pointer
mov Result[ebx], 32
.endif

.else
mov ebx, 0


;free reg 
mov i, edx


f_word_to_res:
cmp WordRealSize, ebx 
jl f_word_to_res_end ; k < temp_word_size
xor eax, eax
mov eax, res_pointer
add eax, ebx  ;; to eax add ebx
xor edx, edx
mov dl, Text_word[ebx]
mov Result[eax],dl
inc ebx
.if (ebx == WordRealSize)
add res_pointer, ebx ;;;res_pointer = res_pointer + k+1;
.endif

;inc ebx ������ �����, �� ��� �� ����� ������ ebx +1
loop f_word_to_res
f_word_to_res_end:

mov edx, i
mov ebx, res_pointer
xor eax, eax
mov al, ReadBuf[edx]
mov Result[ebx], al
inc res_pointer

mov ebx, 0
f_2_clear_word:
cmp WordRealSize, ebx
jl f_2_clear_word_end ; j < WordSize

mov Text_word[ebx], 0

inc ebx
jmp f_clear_word
f_2_clear_word_end:

mov word_pointer,0

.if (ReadBuf[edx + 1] == 32)
mov ebx, res_pointer
mov Result[ebx], 32
.endif
.endif


.else
xor eax, eax
mov al, ReadBuf[edx]
mov ebx, word_pointer
mov Text_word[ebx], al
inc word_pointer

.endif


inc i ; i++
jmp f


f_end:
;���������� ��������� ���� ��� ����������� ����������
push 40h; ����� ���� - ���� ������ "OK"
;� ���������� "�"
push offset Format; ������ ����� �� ���������� 
push offset Result; ������ ����� � ������������ 
push 0; ����� ��������-�������� ����
call MessageBoxA; ������ ������� API
ret
RemoveMiddleLetter ENDP
End DllEntry