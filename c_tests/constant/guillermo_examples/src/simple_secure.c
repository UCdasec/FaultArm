#include <stdio.h>

static short STATE_INIT = 0x5A3C;
static short STATE_PERSO = 0xA5C3;
static short STATE_ISSUED = 0x3C5A;
static short STATE_LOCKED = 0xC3A5;
static short closeHamming1 = 0x3333;
static short closeHamming2 = 0x3332;

int main(int argc, char** argv) {
    int a = 1012;
    int b = 1000;
    int c = 3000;
    printf("Constant coding example.\n");
    return 0;
}