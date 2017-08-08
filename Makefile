loader: boot.asm
	nasm -f bin boot.asm -o boot.bin

floppy: boot.bin
	dd if=/dev/zero of=floppy.img bs=1024 count=1440
	dd if=boot.bin of=floppy.img seek=0 count=1 conv=notrunc

iso: floppy.img
	mkdir iso
	cp floppy.img iso/
	genisoimage -quiet -V 'MYOS' -input-charset iso8859-1 -o boot.iso -b floppy.img -hide floppy.img iso/

clean:
	rm -Rf boot.bin floppy.img iso/ boot.iso
