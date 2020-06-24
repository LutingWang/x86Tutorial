stack   segment stack
        db      100h dup(?)
stack   ends

data    segment
help    db      '1. input some char', 0dh, 0ah
        db      '2. the program will print the char again', 0dh, 0ah
        db      '3. input some string', 0dh, 0ah
        db      '4. checkout `buf`', 0dh, 0ah
        db      '$'
buf_size equ    100
buf     db      buf_size - 1
        db      ?
        db      buf_size dup(?)
data    ends

code    segment
        assume  ss:stack, ds:data, cs:code
putc    macro   ch
        ; print(ch)
        push    ax
        push    dx

        mov     dl, ch
        mov     ah, 2
        int     21h

        pop     dx
        pop     ax
        endm

getc    macro   reg8
        ; reg8 = input()
        push    ax

        mov     ah, 1
        int     21h
        mov     reg8, al

        pop     ax
        endm

puts    macro   str
        ; print(str)
        push    ax
        push    dx

        lea     dx, str
        mov     ah, 9
        int     21h

        pop     dx
        pop     ax
        endm

gets    macro   buf
        ; str = input()
        push    ax
        push    cx
        push    dx
        push    si
        push    di

        lea     dx, buf
        mov     ah, 0ah
        int     21h

        xor     ch, ch
        mov     cl, buf + 1
        lea     di, buf
        lea     si, buf + 2
        rep movsb
        mov     byte ptr [di], '$'

        pop     di
        pop     si
        pop     dx
        pop     cx
        pop     ax
        endm

main    proc    far
        lea     ax, exit
        mov     ax, data
        mov     ds, ax
        mov     es, ax

        puts    help
        getc    dl
        putc    dl
        gets    buf

exit:   mov     ax, 4c00h
        int     21h
main    endp
code    ends
        end     main
