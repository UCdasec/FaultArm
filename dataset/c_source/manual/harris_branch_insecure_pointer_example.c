#include <stdio.h>

int main()
{
    int x = 1;
    int *p = &x;

    if(*p > x){
        printf("Execute critcal code");
    }else {
        printf("Do not excute critical code");
    }
    int z = *p;
    if(x < z && *p){
        printf("Both x < z and *p are true");
    }else{
        printf("Neither x < z and *p are true");
    }
    if(x < z || *p > x){
        printf("Either x < z or *p > x are true");
    }else{
        printf("Neither x < z or *p > x are true");
    }
    int condition = (x * z > *p) ? 1 : 0;
    if(condition){
        printf("x * z is greater than *p");
    }else{
        printf("x * z is less than *p");
    }
    int y = pow(*p,2);
    if(y < x){
        printf("y is less than x");
    }else{
        printf("y is greater than x");
    }
}