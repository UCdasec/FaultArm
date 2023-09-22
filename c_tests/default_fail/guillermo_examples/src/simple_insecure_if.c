#include <stdio.h>

int main(int argc, char** argv) {
    const int FLAG = 0x01;

    if (FLAG == 0x00) {
        printf("Zero");

    } else if (FLAG == 0x01) {
        printf("One");
    } else {
        printf("Default");
    }

    return 0;
}