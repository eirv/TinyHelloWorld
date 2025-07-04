.L.start:
    .ascii  "\177ELF"           // ELFMAG
    mov     w0, #1              // EI_CLASS + EI_DATA + EI_VERSION + EI_OSABI
    adr     x1, .L.str          // EI_PAD
    b       .L.part0            // EI_PAD + 4
    .hword  3                   // e_type = ET_DYN
    .hword  183                 // e_machine = EM_AARCH64
    .int    1                   // e_version
    .quad   4                   // e_entry
    .quad   .L.phdr - .L.start  // e_phoff
.L.str:
    .ascii  "Hello, World!\n"   // e_shoff + e_flags + e_ehsize
    .hword  0x38                // e_phentsize
    .hword  1                   // e_phnum
    .hword  0x40                // e_shentsize
    .hword  0                   // e_shnum
    .hword  0                   // e_shstrndx
.L.phdr:
    .int    1                   // p_type = PT_LOAD
    .int    0x5                 // p_flags = PF_R | PF_X
    .quad   0                   // p_offset
    .quad   0                   // p_vaddr
.L.part0:
    mov     w2, #14             // p_paddr
    b       .L.part1            // p_paddr + 4
    .quad   .L.end - .L.start   // p_filesz
    .quad   .L.end - .L.start   // p_memsz
.L.part1:
    mov     w8, #64             // p_align
    svc     #0                  // p_align + 4
    mov     w0, wzr
    mov     w8, #93
    svc     #0
.L.end:
