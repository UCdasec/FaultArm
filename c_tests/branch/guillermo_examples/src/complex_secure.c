#include <stdio.h>

int main() {
    unsigned int flags = 0xABCD;
    
    if ((flags & 0x0F00) == 0x0100) {
        printf("Flag 1 is set.\n");
    } else {
        printf("Flag 1 is not set.\n");
    }

    if ((flags & 0x00F0) == 0x00A0) {
        printf("Flag 2 is set.\n");
    } else {
        printf("Flag 2 is not set.\n");
    }

    if ((flags & 0x000F) == 0x000D) {
        printf("Flag 3 is set.\n");
    } else {
        printf("Flag 3 is not set.\n");
    }

    return 0;
}

