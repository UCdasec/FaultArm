.LC0:
        .ascii  "Critical code reached.\000"
.LC1:
        .ascii  "Critical code not reached\000"
main:
        push    {r7, lr}
        sub     sp, sp, #16
        add     r7, sp, #0
        str     r0, [r7, #4]
        str     r1, [r7]
        movs    r3, #0
        strb    r3, [r7, #15]
        ldrb    r3, [r7, #15]   @ zero_extendqisi2
        cmp     r3, #0
        beq     .L2
        movw    r0, #:lower16:.LC0
        movt    r0, #:upper16:.LC0
        bl      printf
        b       .L3
.L2:
        movw    r0, #:lower16:.LC1
        movt    r0, #:upper16:.LC1
        bl      printf
.L3:
        movs    r3, #0
        mov     r0, r3
        adds    r7, r7, #16
        mov     sp, r7
        pop     {r7, pc}
