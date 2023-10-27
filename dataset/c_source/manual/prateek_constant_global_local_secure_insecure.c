#include <stdio.h>

int global_secure = 255;

int global_insecure = 1;

#define VAR 128

int main() {
    int local_secure = 16;
    short local_insecure = -1;
    int local_arr[] = {1, 2, 4, 8, 16};
    printNumber(local_secure);
    printNumber(global_insecure);
    return 0;
}

void printNumber(int number) {
    printf("%d", number);
}