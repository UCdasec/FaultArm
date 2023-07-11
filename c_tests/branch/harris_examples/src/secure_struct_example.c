#include <stdio.h>

struct condition
{
    int val1;
    int val2;

};

int main(void){

    struct condition x;
    x.val1 = 0x3F49;
    x.val2 = 0x3F53;

    if (x.val1 < x.val2){
        printf("Execute critical code");
    }else{
        printf("Do not execute critical code");
    }

    struct condition y;
    y.val1 = 0x3F78;
    y.val2 = 0x3F4F;

    if (x.val1 < y.val2 && y.val1 > x.val2){
        printf("both conditions are true");
    }else{
        printf("neither conditions are true");
    }
 
}