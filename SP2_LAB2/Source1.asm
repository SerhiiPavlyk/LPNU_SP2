.686
.model flat, c
 printf proto c : vararg
.data
 msg_error db 'Error, division by zero!', 0
 const_18 dd 18.0
 const_4 dd 4.0
 const_1 dd 1.0
 const_10 dd 10.0
 const_2 dd 2.0
 const_0 dd 0.0
 const_8 dd 8.0
 A dq ?
 C1 dd ?
 D dd ?
.code
 calc PROC
 push ebp
 mov ebp, esp
 finit
 fld qword ptr[ebp+8]
 fst A
 fld dword ptr[ebp+16]
 fst C1
 ;fadd ST(2), ST(0)
 fld dword ptr[ebp+20]
 fst D
 fcom ST(1)
 fstsw ax
 sahf
 jae _fist
 ;(8*lg(d+1)-c)/(a/2+d*c) c > d
 fld const_2; ST0 = 2
 FLDLG2 ; ST0 = lg(2)
 fld D; ST0 = D, ST1 = lg2
 fadd const_1; ST0 = d+1 
 FYL2X ; ST0 = lg(d+1)
 fmul const_8; mul ST0 to 8, ST0 = 8*lg(d+1)
 fsub C1 ; ST0 - C, ST0 = 8*lg(d+1) - c
 fld A; ST0 = a, ST1 = 8*lg(d+1) - c
 fdiv const_2; ST0 = a/2
 fld D; ST0 = d ST1 = a/2, ST2 = 8*lg(d+1) - c
 fmul C1; ST0 = d * c
 fadd ST(0), ST(1); ST(0) = a/2 + d * c
 fcom const_0; check for 0
 fstsw ax
 sahf
 je _error
 fdiv ST(2), ST(0); div 8*lg(d+1) - c to a/2 + d * c
 fld ST(2); move res to ST0
 jmp _end
_fist:;(4*c-ln(d-1))/(a/d+18)
 fld const_2; ST0 = 2
 FLDLN2 ; ST0 = ln(2)
 fld D ; ST1 = ln(2), ST0 = d
 fsub const_1 ; ST0 = d-1
 FYL2X ; ST0 = ln(d-1)
 fld C1; ST0 = c, move ln(d-1) to ST1
 fmul const_4 ; mul 4 with c
 fsub ST(0), ST(1); sub 4c ln(d-1) res to ST(0)
 fld A; ST0 = a, (4c - ln(d-1)) to ST1
 fdiv d; ST0 = a/d
 fadd const_18 ; add a/d 18 ST0 = a/d + 18
 fcom const_0; check for 0
 fstsw ax
 sahf
 je _error
 fdiv ST(1), ST(0) ; div (4c - ln(d-1)) to (a/d+18)
 fld ST(1); move res to ST0
_end:
 pop ebp
 ret
_error:
 invoke printf, offset msg_error, eax
 pop ebp
 ret
 calc ENDP
 END
