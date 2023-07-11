# include <stdio.h>

int main(void)
{
    int x,y = 1;

    // Trivial numerical values
    if (x==1)
    {
        if (y==1)
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