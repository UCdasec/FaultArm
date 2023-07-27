#include <stdio.h>

void secure_simple(void){
    int condition = 0x3f4B;
    int complement = ~(0xf4B);

    if(condition == condition){
        //critical code
    }
    if(~condition == complement){ // check complement
        // continue critical code
    }
}