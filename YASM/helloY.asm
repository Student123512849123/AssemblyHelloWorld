section .data

; -----
; Stale

NULL            equ 0
LF              equ 10
EXIT_SUCCESS    equ 0
STDOUT          equ 1

; -----
; System call codes

SYS_exit        equ 60
SYS_write       equ 1


; -----
; Zmienne

text            db "Hello, world!", LF, NULL

section .text
global _start
_start:
; -----
; Zliczamy liczbe znakow do wyswietlenia

    lea rbx, byte [text]                    ; pobieramy adres tablicy
    mov rdx, 0                              ; zerujemy licznik
CountLoop:
    cmp byte [rbx], NULL                    ; jesli napotkamy na koniec stringu
    je CountDone                            ; konczymy zliczanie
    inc rdx                                 ; licznik++
    inc rbx                                 ; przechodzimy do nastepnego znaku
    jmp CountLoop

CountDone:
    cmp rdx, 0                              ; upewniamy sie czy jest co wyswietlic
    je last

; -----
; Wyswietlamy string na ekranie
; ---------------
; Wywolanie funkcji systemowej write:
; rax: kod funkcji systemowej do wywolania
; write wymaga przekazania trzech argumentow: 
;   - gdzie maja zostac "zapisane dane",
;   - adres tablicy znakow
;   - liczba znakow
; Przykad: write(stdout, text, n);

    mov rax, SYS_write
    mov rdi, STDOUT
    lea rsi, byte [text]
    syscall

last:
    mov rax, SYS_exit
    mov rdi, EXIT_SUCCESS
    syscall
