#include <stdio.h>

int basic_comp() {
    int condition = 1;

    if (condition == 1) {
        printf("Condition is true.\n");
    } else {
        printf("Condition is false.\n");
    }

    int anotherCondition = 0;

    if (anotherCondition) {
        printf("Another condition is true.\n");
    } else {
        printf("Another condition is false.\n");
    }

    return 0;
}


int advanced_comp() {
    int condition = 1;
    int x = 5;
    int y = 10;

    if (condition && x < y) {
        printf("Both condition and x < y are true.\n");
    } else {
        printf("Either condition or x < y is false.\n");
    }

    int anotherCondition = 0;
    int z = 15;

    if (anotherCondition || z > y) {
        printf("Either anotherCondition or z > y is true.\n");
    } else {
        printf("Both anotherCondition and z > y are false.\n");
    }

    int thirdCondition = (x == y) ? 1 : 0;

    if (thirdCondition) {
        printf("x is equal to y.\n");
    } else {
        printf("x is not equal to y.\n");
    }

    return 0;
}

