stack   segment stack
        db      100h dup(?)
stack   ends

data    segment
str1    db      'wangluting$'
str2    db      100 dup(?)
data    ends

code    segment
        assume  ss:stack, ds:data, cs:code
main    proc    far
        lea     ax, exit
        mov     ax, data
        mov     ds, ax
        mov     es, ax

        lea     si, str1
        lea     di, str2
        call    strcpy
        call    strcat
        call    strcmp

exit:   mov     ax, 4c00h
        int     21h
main    endp

strlen  proc
        ; '$' is counted in length
        ; ax = len(di) + 1
        push    cx
        push    di

        mov     ax, '$'
        mov     cx, -1
        cld
        repne scasb
        mov     ax, -1
        sub     ax, cx

        pop     di
        pop     cx
        ret
strlen  endp

strcpy  proc
        ; di = si
        push    si
        push    di

        cld
while_cpy:
        movsb
        cmp     byte ptr [di - 1], '$'
        jne     while_cpy

        pop     di
        pop     si
        ret
strcpy  endp

strcat  proc
        ; di += si
        push    ax
        push    di

        call    strlen
        add     di, ax
        dec     di

        call    strcpy

        pop     di
        pop     ax
        ret
strcat  endp

strcmp  proc
        ; ax = sgn(si - di)
        push    si
        push    di

        cld
while_cmp:
        cmp     byte ptr [si], '$'
        jne     if_cmp_end
        cmp     byte ptr [di], '$'
        je      equal
        jne     less
if_cmp_end:
        cmpsb
        ja      greater
        je      while_cmp
        jb      less

less:   mov     ax, 0ffffh
        jmp     exit_cmp
equal:  mov     ax, 0
        jmp     exit_cmp
greater: 
        mov    ax, 1
        jmp     exit_cmp

exit_cmp:
        pop     di
        pop     si
        ret        
strcmp  endp
code    ends
        end     main
