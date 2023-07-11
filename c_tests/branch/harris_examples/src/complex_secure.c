#include <stdio.h>

int main(){
    // int condition = 
    unsigned int flags = 0xABCD;
    printf("%x, %x, %x, %x, %x", flags, 0x0F00, flags & 0x0F00, flags & 0x00F0, flags & 0x000F);
}