.L.start:
    .ascii  "\177ELF"           // ELFMAG
    leaq    .L.str(%rip), %rsi  // EI_CLASS + EI_DATA + EI_VERSION + EI_OSABI + EI_PAD
    pushq   $14                 // EI_PAD + 3
    popq    %rdx                // EI_PAD + 5
    jmp     .L.part0            // EI_PAD + 6
    .word   3                   // e_type = ET_DYN
    .word   62                  // e_machine = EM_X86_64
.L.part0:
    pushq   $1                  // e_version
    jmp     .L.part1            // e_version + 2
    .quad   4                   // e_entry
    .quad   .L.phdr - .L.start  // e_phoff
.L.str:
    .ascii  "Hello, World!\n"   // e_shoff + e_flags + e_ehsize
    .word   0x38                // e_phentsize
    .word   1                   // e_phnum
.L.part1:
    popq    %rax                // e_shentsize
    movq    %rax, %rdi          // e_shentsize + e_shnum
    jmp     .L.part2            // e_shstrndx
.L.phdr:
    .int    1                   // p_type = PT_LOAD
    .int    0x5                 // p_flags = PF_R | PF_X
    .quad   0                   // p_offset
    .quad   0                   // p_vaddr
.L.part2:
    syscall                     // p_paddr
    pushq   $0                  // p_paddr + 2
    pushq   $60                 // p_paddr + 4
    jmp     .L.part3            // p_paddr + 6
    .quad   .L.end - .L.start   // p_filesz
    .quad   .L.end - .L.start   // p_memsz
.L.part3:
    popq    %rax                // p_align
    popq    %rdi                // p_align + 1
    syscall                     // p_align + 2
    .int    0                   // p_align + 4
.L.end:
