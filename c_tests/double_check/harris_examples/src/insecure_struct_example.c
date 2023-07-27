#include <stdio.h>

struct condition{
    int val1;
};

int main(void){
    struct condition x;
    x.val1 = 0x3F4B;

    if(x.val1){
        //critical code
    }
}