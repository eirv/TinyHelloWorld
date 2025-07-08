.L.start:
    .ascii  "\177ELF"           // ELFMAG
.L.entry:
    leaq    .L.str(%rip), %rsi  // EI_CLASS + EI_DATA + EI_VERSION + EI_OSABI + EI_PAD
    movb    $1, %dil            // EI_PAD + 3
    jmp     .L.part0            // EI_PAD + 6
    .word   3                   // e_type = ET_DYN
    .word   62                  // e_machine = EM_X86_64
.L.part0:
    movb    $1, %al             // e_version
    jmp     .L.part1            // e_version + 2
    .quad   .L.entry - .L.start // e_entry
    .quad   .L.phdr - .L.start  // e_phoff
.L.str:
    .ascii  "Hello, World!\n"   // e_shoff + e_flags + e_ehsize
    .word   0x38                // e_phentsize
/*  deleted */                  // e_phnum
/*  deleted */                  // e_shentsize
/*  deleted */                  // e_shnum
/*  deleted */                  // e_shstrndx
.L.phdr:
    .int    1                   // p_type = PT_LOAD
    .int    0x5                 // p_flags = PF_R | PF_X
    .quad   0                   // p_offset
    .quad   0                   // p_vaddr
.L.part1:
    movb    $14, %dl            // p_paddr
    syscall                     // p_paddr + 2
    movb    $60, %al            // p_paddr + 4
    jmp     .L.part2            // p_paddr + 6
    .quad   .L.end - .L.start   // p_filesz
    .quad   .L.end - .L.start   // p_memsz
.L.part2:
    xorl    %edi, %edi          // p_align
    syscall                     // p_align + 2
    .zero   4                   // p_align + 4
.L.end:
