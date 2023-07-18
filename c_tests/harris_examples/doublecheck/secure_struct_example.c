#include <stdio.h>

struct condition{
    int val1, val2;
};

int main(void){
    struct condition x;
    x.val1 = 0x3F4B;
    x.val2 = ~(0x3F4B);

    if(x.val1){
        //critical code
    }
    if(x.val2 == ~(x.val2)){ //check for complement
        //continue critical code
    }
}