# Even or odd Risc-V

> "Everything is open source if you know assembly"

I've wanted to learn Risc-V assembly for a long time, so now finally, i present my first real project in assembly: A simple *even/odd number checker* which checks if the number given in standard input is even or odd. Idk if its memory safe tho lol.

## Dependencies
Assuming you're not from the future where Risc-V has taken over all CPU marketshare, you will need a cross compiler as well as qemu to compile respectively run the code. For this project we use the following:

- make
- riscv64-linux-gnu-gcc
- qemu-user

The code is then compiled and run as follows.

```bash
make
qemu-riscv64 main
```
