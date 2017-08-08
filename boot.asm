; Boot loader

org		0x7c00
bits	16

start:
    jmp loader

msg	db	"Welcome to My Boot Loader!", 0

print_str:
	lodsb
	or      al, al
	jz      print_done
	mov	    ah,	0eh
	int	    10h
	jmp     print_str
print_done:
	ret

clear_screen:
    push    ax
    xor     ah, ah
    int     10h
    pop     ax
    ret

get_char:
    xor     ax,ax
    int     16h
    ret

loader:
    xor	    ax, ax
	mov	    ds, ax
	mov	    es, ax

    call    clear_screen
	mov	    si, msg
    call    get_char
    call    print_str

    cli
    hlt					      ; halt the system

    times 510 - ($-$$) db 0

    dw 0xAA55
