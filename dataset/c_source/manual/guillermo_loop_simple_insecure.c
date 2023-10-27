#include <stdio.h>
#include <stdbool.h>

void faultDetect() {}

int main()
{

    for(int i = 0; i < 10; i++){
		printf("i = %d\n", i);
	}

    return 0;
}
