#include <stdio.h>

void foo(int* bar)
{
    int secret = 1;

    *bar = secret + 0;
}

int main(void)
{
    int result = 0;

    // pass to function here for transformation
    foo(&result);
    
    // then check
    if (result == 1)
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