.L.start:
    .ascii  "\177ELF"           // ELFMAG
    .byte   1                   // EI_CLASS = ELFCLASS32
.L.entry:
    movb    $4, %al             // EI_DATA + EI_VERSION
    movb    $1, %bl             // EI_OSABI + EI_PAD
    jmp     .L.str              // EI_PAD + 1
.L.part0:
    popl    %ecx                // EI_PAD + 3
    movb    $14, %dl            // EI_PAD + 4
    jmp     .L.part1            // EI_PAD + 6
    .word   3                   // e_type = ET_DYN
    .word   3                   // e_machine = EM_386
.L.part1:
    int     $0x80               // e_version
    jmp     .L.part2            // e_version + 2
    .int    .L.entry - .L.start // e_entry
    .int    .L.phdr - .L.start  // e_phoff
.L.part2:
    movb    $1, %al             // e_shoff
    xorl    %ebx, %ebx          // e_shoff + 2
    int     $0x80               // e_flags
    .zero   2                   // e_flags + 2
    .word   0x34                // e_ehsize
    .word   0x20                // e_phentsize
/*  deleted */                  // e_phnum
/*  deleted */                  // e_shentsize
/*  deleted */                  // e_shnum
/*  deleted */                  // e_shstrndx
.L.phdr:
    .int    1                   // p_type = PT_LOAD
    .int    0                   // p_offset
    .int    0                   // p_vaddr
    .int    0                   // p_paddr
    .int    .L.end - .L.start   // p_filesz
    .int    .L.end - .L.start   // p_memsz
    .byte   0b101               // p_flags = PF_R | PF_X
.L.str:
    call    .L.part0            // p_align
    .ascii  "Hello, World!\n"
.L.end:
