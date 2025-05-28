// decribers aryes datasets
#include "tty.h"
#include "io.h"
#include "display.h"
#include "libc/include/string.h"
#include "libc/include/keyboard.h"



// start terminal output 
void kernel_early(void) {
	terminal_initialize();
}

// load main terminal 
int main(void) {
	char *buff;
	strcpy(&buff[strlen(buff)], "");
	printf("NetWare version 1.0");
	printf("\n");
	printf("Welcome to the NetWare kernel!\n");
	printf("loading keybord driver...\n");
	kbd_init();
	printf("Loading Display driver...\n");
	screen_init();
	}
	


