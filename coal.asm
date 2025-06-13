[org 0x100]
jmp start
paddleA:dw 70
paddleB:dw 3910
innitialA:dw 70
innitialB:dw 3910
starpos:dw 3758
pflag: dw 1  ;1 ha to A ka paddle move kera ga
dirflag:dw 1; 1 ha to B ki baari ma sub 162 or A ki baari ma add 158
	    ; 0 ha to B ki baari ma sub 158 or A ki baari ma add 162 
ticks: dw 0
scoreA:db 0x30
scoreB:db 0x30
row:dw 24
col:dw 40
color: db 0x07
pA:db 'PLAYER A Score ';8+15
pB:db 'PLAYER B Score '
winner: db 'The Winner is: ';15
oldkb: dd 0
oldisr: dd 0
clrscr:
	push bp
	mov bp,sp
	pusha
	push cs
	pop ds
	mov ax,0xb800
	mov es,ax
	mov cx,2000
	mov ax,0x0720
	mov di,0
	rep stosw	;2000 times ya instruction chala gi magar di har dafa 2 increase hoga end pr 4000
	mov di,0
	mov cx,25
	mov si,158
	mov ax,0x7020
faLL:
	mov [es:di],ax
	mov [es:si],ax
	add di,160
	add si,160
	loop faLL
	mov si,pA
	mov di,160
	mov cx,14
	xor ax,ax
	mov ah,0x74
fee:
	lodsb
	stosw
	add di,158
loop fee
	mov di,318
	mov si,pB
	mov cx,14
fal:
	lodsb
	stosw
	add di,158
	loop fal
	popa
	pop bp
	ret
kbisr:
	push bp
	mov bp,sp
	pusha
	push cs
	pop ds
	xor ax,ax
	in al,0x60
	cmp word[pflag],1
	jne toB
	cmp al,0x4B
	jne next
	cmp word[paddleA],0
	je terminate
	sub word [paddleA],10
	jmp terminate
next:
	cmp al,0x4D
	jne terminate
	;cmp word[paddleA],140
	cmp word[paddleA],120
	je terminate
	add word [paddleA],10
	jmp terminate
toB:
	cmp al,0x1F
	;cmp al,0x4B
	jne next2
	cmp word [paddleB],3840
	je terminate
	sub word [paddleB],10
	jmp terminate
next2:
	cmp al,0x20
	;cmp al,0x4D
	jne terminate
	;cmp word[paddleB],3980
	cmp word[paddleB],3960
	je terminate
	add word [paddleB],10
terminate:
	mov al,0x20
	out 0x20,al
	popa
	pop bp
	iret
print_paddle:
	push bp
	mov bp,sp
	pusha
	push cs
	pop ds
	mov ax,0xb800
	mov es,ax
	mov ax,0x7020
	mov cx,[paddleA]
	mov di,cx
	;mov cx,10
	mov cx,20
	rep stosw
	mov cx,[paddleB]
	mov di,cx
	;mov cx,10
	mov cx,20
	rep stosw
	mov al,[scoreA]
	;mov ah,0x7E
	mov ah,0x70
	mov di,2560
	stosw
	mov al,[scoreB]
	mov di,2718
	stosw
	popa
	pop bp
	ret
timer:
	push bp
	mov bp,sp
	pusha
	push cs
	pop ds
	cmp word [ticks],2
	jne print2
	mov word[ticks],0
	mov cx,[starpos]
	mov di,cx
	mov cx,[row]
	mov bx,[col]
	mov ax,0xb800
	mov es,ax
	mov ax,[es:di]
	cmp cx,0
	jg not_this
	cmp ax,0x7020
	jne what
	mov word [pflag],0
	jmp end_isr
what:
	inc byte[scoreB]
	mov word[col],40
	mov word[row],23
	call star
	mov word[dirflag],1
	mov ax,[innitialA]
	mov [paddleA],ax
	mov ax,[innitialB]
	mov [paddleB],ax
jmp print
print2:
	jmp print
not_this:
	cmp word[row],24
	jl abs_not
	cmp ax,0x7020
	jne why
	mov word[pflag],1
	jmp end_isr
why:
	inc byte[scoreA]
	mov word [col],40
	mov word [row],1
	mov word[dirflag],0
	mov ax,[innitialA]
	mov [paddleA],ax
	mov ax,[innitialB]
	mov [paddleB],ax
	jmp print
abs_not:
	cmp word [col],78
	jne yar
	cmp word[dirflag],0
	jne nahi
	mov word[dirflag],1
	jmp end_isr
nahi:
	mov word[dirflag],0
	jmp end_isr
yar:
	cmp word [col],1
	jne end_isr
	cmp word[dirflag],0
	jne naa
	mov word[dirflag],1
	jmp end_isr
naa:
	mov word[dirflag],0
	jmp end_isr
end_isr:
	cmp word[pflag],0
	jne chal	
	cmp word[dirflag],0
	jne yet
	inc word[row]
	inc word [col]
	jmp print
yet:
	dec word[col]
	inc word[row]
	jmp print
chal:
	cmp word[dirflag],0
	jne yat
	dec word[row]
	inc word[col]
	jmp print
yat:
	dec word[row]
	dec word[col]
print:
	call clrscr
	call print_paddle
	call star
	call print_star
	inc word [ticks]
	mov al,0x20
	out 0x20,al
	popa
	pop bp
	iret
star:
	push bp
	mov bp,sp
	pusha
	push cs
	pop ds
	xor ax,ax
	mov al,80
	mul byte[row]
	add ax,[col]
	shl ax,1
	mov [starpos],ax
	popa
	pop bp
	ret
print_star:
	push bp
	mov bp,sp
	pusha
	push cs
	pop ds
	mov ax,0xb800
	mov es,ax
	mov cx,[starpos]
	cmp cx,160
	jl return
	cmp cx,3840
	jg return
	mov di,cx
	mov ax,0x072A
	mov ah,[color]
	stosw
	cmp byte[color],0x08
	jne return 
	mov byte[color],0x00
return:
	;inc byte[color]
	popa
	pop bp
	ret
delay:
    push cx
    mov cx, 3 
delay_loop1:
    push cx
    mov cx, 0xFFFF
delay_loop2:
    loop delay_loop2
    pop cx
    loop delay_loop1
    pop cx
    ret 
print_winner:
	push bp
	mov bp,sp
	pusha
	mov ax,0xb800
	mov es,ax
	mov si,winner
	mov di,1950
	mov cx,15
	xor ax,ax
	mov ah,0x70
flee:
	lodsb
	stosw
	call delay
loop flee
	mov cx,8
	mov ah,0x74
	cmp byte [scoreA],0x35
	jne check
	mov si,pA
	jmp count
check:
	mov si,pB
count:
	lodsb
	stosw
	call delay
	call delay
loop count
 	popa
	pop bp
	ret	
start:
	call clrscr
cli
	xor ax,ax
	mov es,ax
	mov ax,[es:0x08*4]
	mov [oldisr],ax
	mov ax,[es:0x08*4 + 2]
	mov [oldisr+2],ax
	mov ax,[es:0x09*4]
	mov [oldkb],ax
	mov ax,[es:0x09*4+2]
	mov [oldkb+2],ax
	xor ax,ax
	mov es,ax
	mov word [es:0x08*4],timer
	mov [es:0x08*4 + 2],cs
	mov word [es:0x09*4],kbisr
	mov [es:0x09*4+2],cs
sti
ft:
	cmp byte[scoreA],0x35
	je  wapis
	cmp byte[scoreB],0x35
	je  wapis
	jmp ft
wapis:
	call clrscr
	call print_paddle
	xor ax,ax
	mov es,ax
	mov ax,[oldisr]
	mov [es:8*4],ax
	mov ax,[oldisr+2]
	mov [es:8*4+2],ax
	mov ax,[oldkb]
	mov [es:9*4],ax
	mov ax,[oldkb+2]
	mov [es:9*4+2],ax
	call print_winner
	mov ax,0x4c00
	int 0x21