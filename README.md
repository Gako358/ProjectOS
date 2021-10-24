The kernel
----------

The C kernel will just print an 'X' on the top left corner of the screen.

The dummy function does nothing. That function will force 
to create a kernel entry routine which does not point to byte 0x0 in our kernel, but
to an actual label which we know that launches it. In this case, function `main()`.

`i386-elf-gcc -ffreestanding -c kernel.c -o kernel.o`

To compile this file, instead of generating
a binary, we will generate an `elf` format file which will be linked with `kernel.o`

`nasm kernel_entry.asm -f elf -o kernel_entry.o`


The linker
----------

To link both object files into a single binary kernel and resolve label references,
run:

`i386-elf-ld -o kernel.bin -Ttext 0x1000 kernel_entry.o kernel.o --oformat binary`

The kernel will be placed not at `0x0` in memory, but at `0x1000`. The
bootsector will need to know this address too.


The bootsector
--------------

Compile it with `nasm bootsect.asm -f bin -o bootsect.bin`


Putting it all together
-----------------------

Concatenate them:

`cat bootsect.bin kernel.bin > os-image.bin`


Run!
----

You can now run `os-image.bin` with qemu.

Remember that if you find disk load errors you may need to play with the disk numbers
or qemu parameters (floppy = `0x0`, hdd = `0x80`). I usually use `qemu-system-i386 -fda os-image.bin`

You will see four messages:

- "Started in 16-bit Real Mode"
- "Loading kernel into memory"
- (Top left) "Landed in 32-bit Protected Mode"
- (Top left, overwriting previous message) "X"

