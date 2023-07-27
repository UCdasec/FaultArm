#include <stdio.h>

int main(void)
{
    int result = 0x3ca5;

    // Non-trivial numerical value
    if (result == 0x3ca5)
    {
        printf("Executing critical code...\n");
    }
    else
    {
        printf("Exiting out...\n");
        return 1;
    }

    return 0;
}