stack   segment stack
        db      100h dup(?)
stack   ends

data    segment
buf_size equ    100
buf     db      buf_size - 1
        db      ?
        db      buf_size dup(?)
data    ends

code    segment
        assume ss:stack, ds:data, cs:code
main    proc    far
        lea     ax, exit
        mov     ax, data
        mov     ds, ax
        mov     es, ax


exit:   mov     ax, 4c00h
        int     21h
main    endp
code    ends
        end     main
