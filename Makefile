CC=gcc
TARGET=myos
C_FILES=./kernel/libc/string/memcmp.c \
	./kernel/libc/string/memset.c \
	./kernel/libc/string/strcat.c \
	./kernel/libc/string/strchr.c \
	./kernel/libc/string/strcmp.c \
	./kernel/libc/string/strcpy.c \
	./kernel/libc/string/strlen.c \
	./kernel/libc/string/strncmp.c \
	./kernel/libc/string/strstr.c \
	./kernel/libc/string/strutil.c \
	./kernel/libc/string/ctos.c \
	./kernel/tty.c \
	./kernel/io.c \
	./kernel/keyboard.c \
	./kernel/idt.c \
	./kernel/irq.c \
	./kernel/pit.c \
	./kernel/serial.c \
	./kernel/portio.c \
	./kernel/descriptor.c \
	./kernel/interrupt.c \
	./kernel/console.c \
	./kernel/display.c	\
	./kernel/kernel.c
OBJS=$(C_FILES:.c=.o)

all compile: $(TARGET)
all: finale
.PHONY: all compile clean finale

%.o:
	$(CC) -c $(@:.o=.c) -o $@ -ffreestanding -fno-exceptions -m32

$(TARGET): $(OBJS)
	$(shell nasm -f elf start.asm -o start.o)
	$(CC) -m32 -nostdlib -nodefaultlibs -lgcc start.o $? -T linker.ld -o $(TARGET)

finale:
	$(shell cd ~/NetWare_build/LDAP_BUILD_0001/)
	$(shell cp $(TARGET) ./iso/boot/$(TARGET))
	$(shell grub-mkrescue iso --output=$(TARGET).iso)

clean:
	rm -f *.o $(TARGET) $(TARGET).iso
	find . -name \*.o | xargs --no-run-if-empty rm
