#include <stdio.h>

int main()
{
    int x = 10;
    int *p = &x;
    int y = ~(*p);

    if(*p == &x){
        //critical code
    }
    if(y == y){ //check for complement
        //continue critical code
    }
}