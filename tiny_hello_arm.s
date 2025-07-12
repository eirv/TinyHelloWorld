    .thumb_func
.L.start:
    .ascii  "\177ELF"           // ELFMAG
.L.entry:
    ldr     r0, .L.one          // EI_CLASS + EI_DATA
    adr     r1, .L.str + 0      // EI_VERSION + EI_OSABI + EI_PAD
    mov     r2, #14             // EI_PAD + 2
    b       .L.part0            // EI_PAD + 6
    .hword  3                   // e_type = ET_DYN
    .hword  40                  // e_machine = EM_ARM
    .int    0                   // e_version
    .int    .L.entry - .L.start + 1 // e_entry
    .int    .L.phdr - .L.start  // e_phoff
.L.part0:
    mov     r7, #4              // e_shoff
    swi     #0                  // e_flags
    ldr     r7, .L.one          // e_flags + 2
    b       .L.part1            // e_ehsize
    .hword  0x20                // e_phentsize
/*  deleted */                  // e_phnum
/*  deleted */                  // e_shentsize
/*  deleted */                  // e_shnum
/*  deleted */                  // e_shstrndx
.L.phdr:
.L.one:
    .int    1                   // p_type = PT_LOAD
    .int    0                   // p_offset
    .int    0                   // p_vaddr
.L.part1:
    mov     r0, r3              // p_paddr
    swi     #0                  // p_paddr + 4
    .int    .L.end - .L.start   // p_filesz
    .int    .L.end - .L.start   // p_memsz
    .byte   0b101               // p_flags = PF_R | PF_X
.L.str:
    .ascii  "Hello, World!\n"   // p_align
.L.end:
