stack   segment stack
        db      100h dup(?)
stack   ends

data    segment
num     dw      56ABh, 1234h, 1173h, 1723h
int16   db      5 dup(?), '$'
hex16   db      4 dup(?), '$'
long    db      20 dup(?), '$'
data    ends

code    segment
        assume ss:stack, ds:data, cs:code
main    proc    far
        lea     ax, exit
        mov     ax, data
        mov     ds, ax
        mov     es, ax

        call    itoa
        call    htoa
        call    ltoa

exit:   mov     ax, 4c00h
        int     21h
main    endp

itoa    proc
        ; int16 = str(num)
        push    ax
        push    bx
        push    cx
        push    dx
        push    di

        mov     ax, num
        mov     bx, 10

        mov     cx, 5
while_itoa:
        xor     dx, dx
        div     bx
        add     dx, '0'
        mov     di, cx
        mov     int16[di - 1], dl
        loop    while_itoa

        pop     di
        pop     dx
        pop     cx
        pop     bx
        pop     ax
        ret
itoa    endp

htoa    proc
        ; hex16 = hex(num)
        push    ax
        push    bx
        push    cx
        push    dx
        push    di

        mov     ax, num
        mov     bx, 10h

        xor     ch, ch
        mov     cl, 4
while_htoa:
        xor     dx, dx
        div     bx
        add     dx, '0'
        cmp     dx, '9'
        jbe     if_htoa_end
        add     dx, 'A' - '9' - 1
if_htoa_end:
        mov     di, cx
        mov     hex16[di - 1], dl
        loop    while_htoa

        pop     di
        pop     dx
        pop     cx
        pop     bx
        pop     ax
        ret
htoa    endp

ltoa    proc
        ; long = int(num)
        push    ax
        push    bx
        push    cx
        push    dx
        push    si
        push    di

        mov     bx, 10
        mov     cx, 20
while_ltoa_1:
        xor     dx, dx
        lea     si, num + 8
while_ltoa_2:
        sub     si, 2
        mov     ax, [si]
        div     bx
        mov     [si], ax
        cmp     si, offset num
        ja      while_ltoa_2
        add     dx, '0'
        mov     di, cx
        mov     long[di - 1], dl
        loop    while_ltoa_1

        pop     di
        pop     si
        pop     dx
        pop     cx
        pop     bx
        pop     ax
        ret
ltoa    endp
code    ends
        end     main
