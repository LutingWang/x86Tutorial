stack   segment stack
        db      100h dup(?)
stack   ends

data    segment
x       dd      12345678h
y       dd      17231173h
z       dw      4 dup(?)
data    ends

code    segment
        assume ss:stack, ds:data, cs:code
main    proc    far
        lea     ax, exit
        mov     ax, data
        mov     ds, ax
        mov     es, ax

        call    mult

exit:   mov     ax, 4c00h
        int     21h
main    endp

mult    proc
        ; z = x * y
        push    ax
        push    dx

        mov     ax, word ptr x
        mov     dx, word ptr y
        mul     dx
        add     z, ax
        adc     z + 2, dx
        adc     z + 4, 0

        mov     ax, word ptr x
        mov     dx, word ptr y + 2
        mul     dx
        add     z + 2, ax
        adc     z + 4, dx
        adc     z + 6, 0

        mov     ax, word ptr x + 2
        mov     dx, word ptr y
        mul     dx
        add     z + 2, ax
        adc     z + 4, dx
        adc     z + 6, 0

        mov     ax, word ptr x + 2
        mov     dx, word ptr y + 2
        mul     dx
        add     z + 4, ax
        adc     z + 6, dx

        pop     dx
        pop     ax
        ret
mult    endp
code    ends
        end     main
