;BootColor.bin
;written by Chris Carlin
;to compile:
;nasm -f bin BootColor.asm -o BootColor.bin
	
	org 07c00h		;sets the origin to where the bios should look
	
	mov al, 13h		;function to set graphics mode
	mov ah, 0	
	int 10h     	; set graphics video mode. 
	
	mov al, 1100b	;set color to light red
	mov cx, 0
	mov dx, 0
	mov ah, 0ch
	int 10h     	;set pixel.
	
l:	;loop entry point
	
	add cx,1
	add dx,1
	int 10h			;set pixel again
	
	cmp cx, 0FFFFh	;if count is at max of word
	je next			;goto next

	jmp l 			;goes back to top of loop if cx isn't at FFFF
	
next:	;sets up for next color
	cmp al,1111b 	;check to see if the color limit is met
	je reset		;Then jumps to reset color
	add al, 0001b	;increment color by 1
	mov dx, 0
	mov cx, 0
	jmp l			;back to loop
	
reset:	;resets color
	mov al, 0000b
	jmp l			;goes back to the loop
	