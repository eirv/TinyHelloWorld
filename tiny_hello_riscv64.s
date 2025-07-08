.L.start:
    .ascii  "\177ELF"           // ELFMAG
    .byte   2                   // EI_CLASS = ELFCLASS64
    .byte   1                   // EI_DATA = ELFDATA2LSB
    lla     a1, .L.str          // EI_VERSION + EI_OSABI + EI_PAD
    j       .L.part0            // EI_PAD + 6
    .hword  3                   // e_type = ET_DYN
    .hword  243                 // e_machine = EM_RISCV
.L.part0:
    li      a0, 1               // e_version
    j       .L.part1            // e_version + 2
    .quad   6                   // e_entry
    .quad   .L.phdr - .L.start  // e_phoff
.L.str:
    .ascii  "Hello, World!\n"   // e_shoff + e_flags + e_ehsize
    .hword  0x38                // e_phentsize
    .hword  1                   // e_phnum
.L.part1:
    li      a2, 14              // e_shentsize
    j       .L.part2            // e_shnum
/*  deleted */                  // e_shstrndx
.L.phdr:
    .int    1                   // p_type = PT_LOAD
    .int    0x5                 // p_flags = PF_R | PF_X
    .quad   0                   // p_offset
    .quad   0                   // p_vaddr
.L.part2:
    li      a7, 64              // p_paddr
    j       .L.part3            // p_paddr + 4
    .zero   2                   // p_paddr + 6
    .quad   .L.end - .L.start   // p_filesz
    .quad   .L.end - .L.start   // p_memsz
.L.part3:
    ecall                       // p_align
    li      a0, 0               // p_align + 4
    li      a7, 93              // p_align + 6
/*  ecall */ .byte 0x73
.L.end:
