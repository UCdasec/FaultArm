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

    // switch (FLAG)
    // {
    // case 0:
    //     printf("Zero");
    //     break;
    // case 1:
    //     printf("One");
    //     break;
    // case 2:
    //     printf("Two");
    //     break;
    // default:
    //     printf("Default");
    //     break;
    // }

    return 0;
}