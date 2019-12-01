%include "include/io.inc"

extern atoi
extern printf
extern exit

; Functions to read/free/print the image.
; The image is passed in argv[1].
extern read_image
extern free_image
; void print_image(int* image, int width, int height);
extern print_image

; Get image's width and height.
; Store them in img_[width, height] variables.
extern get_image_width
extern get_image_height

section .data
	use_str db "Use with ./tema2 <task_num> [opt_arg1] [opt_arg2]", 10, 0

section .bss
    task:       resd 1
    img:        resd 1
    img_width:  resd 1
    img_height: resd 1

section .text

; receives 2 letters, returns 1 if they are equal, 0 otherwise
;check_letter:
    ;push ebp
    ;mov ebp, esp
    
    ; saving the value of ebx on the stack
    ;push ebx

   ; mov ebx, DWORD[ebp + 8]
    ;xor eax, eax

   ; cmp ebx, DWORD[ebp + 12]
  ;  jne end_check_letter
    
 ;   mov eax, 1
    
;end_check_letter:
    ;pop ebx

    ;leave
    ;ret
    

bruteforce_singlebyte_xor:
    push ebp
    mov ebp, esp

    ; the address of the matrix is stored in eax
    mov eax, [ebp + 8]
    
    ; for correct iteration
    sub DWORD[img_width], 6
    
    xor ecx, ecx
    
other_key_value:
    ; saving the key value on the stack
    push ecx
    mov edx, ecx

    xor ecx, ecx

row_iterate:
    ; saving the row number on the stack
    push ecx

    ; ebx is the offset for the first element in the current row
    add ebx, ecx

    xor ecx, ecx
    
column_iterate:
    ; saving the column number on the stack
    push ebx
    push ecx
    
    ; checking for letter 'r'
    ; the pixel value is moved in eax
    mov eax, [ebp + 8]
    mov eax, [eax + ebx]
    
    ; xor with the key    
    xor eax, edx

    cmp eax, 'r'
    jne end_column_iterate
    
    ; checking for letter 'e'
    inc ebx
    inc ecx

    mov eax, [ebp + 8]
    mov eax, [eax + ebx]

    xor eax, edx

    cmp eax, 'e'
    jne end_column_iterate

    ; checking for letter 'v'
    inc ebx
    inc ecx

    mov eax, [ebp + 8]
    mov eax, [eax + ebx]

    xor eax, edx

    cmp eax, 'v'
    jne end_column_iterate

    ; checking for letter 'i'
    inc ebx
    inc ecx

    mov eax, [ebp + 8]
    mov eax, [eax + ebx]

    xor eax, edx

    cmp eax, 'i'
    jne end_column_iterate

    ; checking for letter 'e'
    inc ebx
    inc ecx

    mov eax, [ebp + 8]
    mov eax, [eax + ebx]

    xor eax, edx

    cmp eax, 'e'
    jne end_column_iterate

    ; checking for letter 'n'
    inc ebx
    inc ecx

    mov eax, [ebp + 8]
    mov eax, [eax + ebx]

    xor eax, edx

    cmp eax, 'n'
    jne end_column_iterate

    ; checking for letter 't'
    inc ebx
    inc ecx

    mov eax, [ebp + 8]
    mov eax, [eax + ebx]

    xor eax, edx

    cmp eax, 't'
    jne end_column_iterate

end_column_iterate:
    inc ebx
    inc ecx

    ; if it is not the last possible position for revient continue iterating
    cmp ecx, DWORD[img_width]
    jne column_iterate
    
    
    ; the current row number is taken of stack
    pop ecx
    inc ecx
    
    ; continue only if this is not the last row
    cmp ecx, DWORD[img_height]
    jne row_iterating

    ; taking the key value off the stack
    pop ecx
    inc ecx

    ; the input certainly contains the word so this jump is unconditioned
    jmp other_key_value
    
    
found:
    ; finding on what line "revient" is and storing it in eax
    xor edx, edx
    mov eax, ecx
    mov ebx, [img_width]
    div ebx

    ; adding the last element of the line on stack, setting it to 0
    mov ebx, [ebp + 8]
    mov ecx, [img_width]
    add ecx, eax
    
    xor edx, edx
    mov dl, [ebx + ecx - 1] 
    push edx

    mov BYTE[ebx + ecx - 1], 0
       
    push "%s\n"
    push ebx
    call printf
    add esp, 8
    
    ; setting the last element of the line back to its initial value
    pop edx
    mov BYTE[ebx + ecx - 1], dl

    ; taking off the stack the elements added there before
    add esp, 12

    ; restoring img_width to its initial value
    add DWORD[img_width], 6
    
    leave
    ret

global main
main:
    ; Prologue
    ; Do not modify!
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]
    cmp eax, 1
    jne not_zero_param

    push use_str
    call printf
    add esp, 4

    push -1
    call exit

not_zero_param:
    ; We read the image. You can thank us later! :)
    ; You have it stored at img variable's address.
    mov eax, [ebp + 12]
    push DWORD[eax + 4]
    call read_image
    add esp, 4
    mov [img], eax

    ; We saved the image's dimensions in the variables below.
    call get_image_width
    mov [img_width], eax

    call get_image_height
    mov [img_height], eax

    ; Let's get the task number. It will be stored at task variable's address.
    mov eax, [ebp + 12]
    push DWORD[eax + 8]
    call atoi
    add esp, 4
    mov [task], eax

    ; There you go! Have fun! :D
    mov eax, [task]
    cmp eax, 1
    je solve_task1
    cmp eax, 2
    je solve_task2
    cmp eax, 3
    je solve_task3
    cmp eax, 4
    je solve_task4
    cmp eax, 5
    je solve_task5
    cmp eax, 6
    je solve_task6
    jmp done

solve_task1:    
    push DWORD[img]
    call bruteforce_singlebyte_xor
    add esp, 4
    jmp done

solve_task2:
    ; TODO Task2
    jmp done
solve_task3:
    ; TODO Task3
    jmp done
solve_task4:
    ; TODO Task4
    jmp done
solve_task5:
    ; TODO Task5
    jmp done
solve_task6:
    ; TODO Task6
    jmp done

    ; Free the memory allocated for the image.
done:
    push DWORD[img]
    call free_image
    add esp, 4

    ; Epilogue
    ; Do not modify!
    xor eax, eax
    leave
    ret
    
