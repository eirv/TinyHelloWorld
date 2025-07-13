# Tiny Hello World

112-byte x64 Linux ELF executable written in pure assembly.  
Prints `Hello, World!` by optimizing ELF headers and syscalls.  
A study in minimal binary design.  

## Build

```
 $ clang -nostartfiles -static -Wl,--as-needed,--oformat=binary -o tiny_hello_x64 tiny_hello_x64.s
 $ ./tiny_hello_x64
Hello, World!
```

## Size comparison

|          | Assembly |   C   |   C++   |
| :------- | :------: | :---: | :-----: |
|  x86_64  |   112B   |   3K  |   50K   |
|  AArch64 |   124B   |   4K  |   49K   |
| RISC-V64 |   112B   |   4K  |   45K   |
|    x86   |    83B   |   2K  |   47K   |
|    ARM   |    83B   |   2K  |   43K   |

> The `x86_64`, `RISC-V64`, `x86`, and `ARM` architectures have reached the limits of the ELF format, so they cannot be made any smaller.

<details><summary>Sources</summary>

- C
```c
#include <stdio.h>

int main() {
  printf("Hello, World!\n");
}
```
- C++
```cpp
#include <print>

int main() {
  std::println("Hello, World!");
}
```
</details>
