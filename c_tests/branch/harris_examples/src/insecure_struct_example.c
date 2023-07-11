#include <stdio.h>

struct condition
{
    int val1;
    int val2;

};

int main(void){

    struct condition x;
    x.val1 = 10;
    x.val2 = 12;

    if (x.val1 < x.val2){
        printf("Execute critical code");
    }else{
        printf("Do not execute critical code");
    }

    struct condition y;
    y.val1 = 30;
    y.val2 = 15;

    if (x.val1 < y.val2 && y.val1 > x.val2){
        printf("both conditions are true");
    }else{
        printf("neither conditions are true");
    }
 
}
