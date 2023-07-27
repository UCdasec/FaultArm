# include <stdio.h>

int main(void)
{
    // x and y shouldn't have the same  values
    int x = 0x3F40;
    int y = 0x3F6C;

    // Trivial numerical values
    if (x==0x3F40)
    {
        if (y==0x3F6C)
        {
            printf("Executing critical code... \n");
        }
        else 
        {
            printf("Exiting out...\n");
            return 2;
        }
    }
    else 
    {
         printf("Exiting out...\n");
         return 1;
    }
    return 0;
}