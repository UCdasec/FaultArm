#include <stdio.h>

void insecure_simple(void){
    int condition = 0x3f4B;

    if(condition == condition){
        //critical code
    }
}