stack   segment stack
        db      100h dup(?)
stack   ends

data    segment
result  dw      ?
data    ends

code    segment
        assume ss:stack, ds:data, cs:code
main    proc    far
        lea     ax, exit
        mov     ax, data
        mov     ds, ax
        mov     es, ax

        mov     ax, 6
        push    ax
        call    fact

exit:   mov     ax, 4c00h
        int     21h
main    endp

fact    proc    ; n
        ; ax = [bp + 4]!
        push    bp
        mov     bp, sp
        push    ax
        push    dx

        mov     ax, [bp + 4]
        cmp     ax, 1
        ja      if_fact_end
        mov     result, 1
        jmp     exit_fact
if_fact_end:

        dec     ax
        push    ax
        call    fact
        inc     ax
        mov     dx, result
        mul     dx
        mov     result, ax

exit_fact:
        pop     dx
        pop     ax
        pop     bp
        ret     2
fact    endp
code    ends
        end     main
