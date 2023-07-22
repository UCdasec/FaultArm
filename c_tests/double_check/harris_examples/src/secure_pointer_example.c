#include <stdio.h>

int main()
{
    int x = 0x3f4B;
    int *p = &x;
    int y = ~(*p);

    if(*p == &x){
        //critical code
    }
    if(y == y){ //check for complement
        //continue critical code
    }
}