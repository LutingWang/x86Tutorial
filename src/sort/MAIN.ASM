stack   segment stack
        db      100h dup(?)
stack   ends

data    segment
table   db      17h, 23h, 11h, 73h, 12h, 34h, 56h, 78h
table_len equ   $ - table
data    ends

code    segment
        assume ss:stack, ds:data, cs:code
main    proc    far
        lea     ax, exit
        mov     ax, data
        mov     ds, ax
        mov     es, ax

        call    sort

exit:   mov     ax, 4c00h
        int     21h
main    endp

sort    proc
        ; sort(table)
        push    ax
        push    bx
        push    si

while_sort_1:
        xor     bx, bx
        xor     si, si
while_sort_2:
        mov     al, table[si]
        cmp     al, table[si + 1]
        jbe     if_sort_end
        xchg    al, table[si + 1]
        mov     table[si], al
        mov     bx, 1
if_sort_end:
        inc     si
        cmp     si, table_len - 1
        jb      while_sort_2
        cmp     bx, 0
        jne     while_sort_1

        pop     si
        pop     bx
        pop     ax
        ret
sort    endp
code    ends
        end     main
