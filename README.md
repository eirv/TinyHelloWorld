# Tiny Hello World

120-byte x64 Linux ELF executable written in pure assembly.  
Prints "Hello, World!" by optimizing ELF headers and syscalls.  
A study in minimal binary design.  

```bash
 $ clang -nostartfiles -static -Wl,--as-needed,--oformat=binary -o tiny_hello_x64 tiny_hello_x64.s
 $ ./tiny_hello_x64
Hello, World!
```
