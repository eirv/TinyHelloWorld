.L.start:
    .ascii  "\177ELF"           // ELFMAG
    .byte   2                   // EI_CLASS = ELFCLASS64
    .byte   1                   // EI_DATA = ELFDATA2LSB
.L.entry:
    lla     a1, .L.str          // EI_VERSION + EI_OSABI + EI_PAD
    j       .L.part0            // EI_PAD + 6
    .hword  3                   // e_type = ET_DYN
    .hword  243                 // e_machine = EM_RISCV
.L.part0:
    li      a0, 1               // e_version
    j       .L.part1            // e_version + 2
    .quad   .L.entry - .L.start // e_entry
    .quad   .L.phdr - .L.start  // e_phoff
.L.str:
    .ascii  "Hello, World!\n"   // e_shoff + e_flags + e_ehsize
    .hword  0x38                // e_phentsize
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
    li      a2, 14              // p_paddr
    li      a7, 64              // p_paddr + 2
    j       .L.part2            // p_paddr + 6
    .quad   .L.end - .L.start   // p_filesz
    .quad   .L.end - .L.start   // p_memsz
.L.part2:
    ecall                       // p_align
    li      a0, 0               // p_align + 4
    li      a7, 93              // p_align + 6
/*  ecall */ .byte 0x73
.L.end:
