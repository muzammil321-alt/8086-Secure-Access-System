; ************************************************************
; Project: 8086 Secure Access System
; Developed by: Muhammed Muzammil (Muzi)
; ************************************************************

ORG 100h

JMP START

; --- SECURITY DATA ---
msg_prompt DB 'SYSTEM SECURED. Enter 4-Digit PIN: $'
msg_grant  DB 13, 10, 'ACCESS GRANTED. Welcome, Muzi! $'
msg_deny   DB 13, 10, 'ACCESS DENIED. System Lockdown Implemented! $'
stored_pin DB '2026'              ; Aapka secret PIN code
user_input DB 4 DUP(0)            ; Memory allocation for input

START:
    ; --- Display Security Prompt ---
    MOV DX, OFFSET msg_prompt
    MOV AH, 09h
    INT 21h

    ; --- Secure Input Logic (No Echo) ---
    MOV CX, 4                     ; 4 iterations for 4 digits
    MOV SI, 0                     ; Starting index

INPUT_LOOP:
    MOV AH, 07h                   ; AH 07h use karne se keyboard input screen par nahi dikhta
    INT 21h
    
    MOV user_input[SI], AL        ; Input character ko memory buffer mein save karein
    
    ; Output '*' as visual feedback for security
    MOV DL, '*'
    MOV AH, 02h
    INT 21h
    
    INC SI                        ; Move to next memory location
    LOOP INPUT_LOOP               ; Repeat for 4 digits

    ; --- Memory Comparison Logic ---
    MOV SI, 0                     ; Reset SI index
    MOV CX, 4                     ; Reset counter

CHECK_PIN:
    MOV AL, user_input[SI]        ; User input fetch karein
    MOV BL, stored_pin[SI]        ; Stored PIN fetch karein
    
    CMP AL, BL                    ; Compare bits (Hardware level check)
    JNE LOCKDOWN                  ; Agar ek bhi bit match na ho, lockdown par jayein
    
    INC SI
    LOOP CHECK_PIN                ; Aglay digit par jayein

    ; --- Result: Access Success ---
    MOV DX, OFFSET msg_grant
    MOV AH, 09h
    INT 21h
    JMP FINISH

LOCKDOWN:
    ; --- Result: Security Breach ---
    MOV DX, OFFSET msg_deny
    MOV AH, 09h
    INT 21h

FINISH:
    RET                           ; Exit COM program
END
