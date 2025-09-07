default:
	rm -f main
	#riscv64-linux-gnu-as main.s -o main.o # If i had this i would need to fix the gp myself and idk how to do that lol.
	riscv64-linux-gnu-gcc -o main main.s -nostdlib -static # jag har glömt hans namn lol men tack bror
