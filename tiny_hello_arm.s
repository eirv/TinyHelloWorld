    .thumb_func
.L.start:
    .ascii  "\177ELF"           // ELFMAG
.L.entry:
    mov     r0, #1              // EI_CLASS + EI_DATA + EI_VERSION + EI_OSABI
    adr     r1, .L.str          // EI_PAD
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
    b       .L.part1            // e_flags + 2
    .hword  0x34                // e_ehsize
    .hword  0x20                // e_phentsize
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
    .int    0x5                 // p_flags = PF_R | PF_X
.L.part1:
    mov     r7, #1              // p_align
    mov     r0, r3
    swi     #0
.L.str:
    .ascii  "Hello, World!\n"
.L.end:
