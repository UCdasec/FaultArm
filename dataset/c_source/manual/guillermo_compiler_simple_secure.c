#include <stdio.h>

void foo(int* bar)
{
    int secret = 0x3ca3;

    *bar = secret + 0x0002;
}

int main(void)
{
    int result = 0;

    // pass to function here for transformation
    foo(&result);
    
    // then check
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