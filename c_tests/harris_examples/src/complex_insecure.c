#include <stdio.h>
#include <stdlib.h>

int basic_comp()
{
    int condition = 1;
    branch_check(condition);

}
int branch_check(int x)
{
    if (x == 1)
    {
        printf("Executing critical code... \n");
    }
    else{
        printf("Exiting out... \n");
    }
    return 0;
}

int adv_comp()
{
    int condition = 1;
    int x = 8;
    int y = 10;

    if (x < y && branch_check(condition))
    {
        printf("Both x < y and condition are true. \n");
    }
    else 
    {
        printf("Both x < y and condition are false. \n");
    }

    int anothercondition = 0;
    int z = 12;

    if (branch_check(anothercondition) || z > y)
    {
       if(branch_check(condition))
       {
         printf("Either anothercondition or z > y is true and condition is true. \n");
       }
       else
      {
         printf("Either anothercondition or z > y is true but condition is false. \n");
         }
    }
    else {
        printf("Both anotherCondition and z > y are false.\n");
    }
}   