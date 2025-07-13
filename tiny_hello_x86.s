.L.start:
    .ascii  "\177ELF"           // ELFMAG
.L.entry:
    movb    $4, %al             // EI_CLASS + EI_DATA
    movb    $1, %bl             // EI_VERSION + EI_OSABI
    call    .L.part0            // EI_PAD
.L.part0:
    popl    %ecx                // EI_PAD + 5
    jmp     .L.part1            // EI_PAD + 6
    .word   3                   // e_type = ET_DYN
    .word   3                   // e_machine = EM_386
.L.part1:
    movb    $14, %dl            // e_version
    jmp     .L.part2            // e_version + 2
    .int    .L.entry - .L.start // e_entry
    .int    .L.phdr - .L.start  // e_phoff
.L.part2:
    addl    $(.L.str - .L.part0), %ecx // e_shoff
    int     $0x80               // e_shoff + 3
    movb    $1, %al             // e_flags + 1
    jmp     .L.part3            // e_flags + e_ehsize
    .zero   1                   // e_ehsize + 1
    .word   0x20                // e_phentsize
/*  deleted */                  // e_phnum
/*  deleted */                  // e_shentsize
/*  deleted */                  // e_shnum
/*  deleted */                  // e_shstrndx
.L.phdr:
    .int    1                   // p_type = PT_LOAD
    .int    0                   // p_offset
    .int    0                   // p_vaddr
.L.part3:
    xorl    %ebx, %ebx          // p_paddr
    int     $0x80               // p_paddr + 2
    .int    .L.end - .L.start   // p_filesz
    .int    .L.end - .L.start   // p_memsz
    .byte   0b101               // p_flags = PF_R | PF_X
.L.str:
    .ascii  "Hello, World!\n"   // p_align
.L.end:
