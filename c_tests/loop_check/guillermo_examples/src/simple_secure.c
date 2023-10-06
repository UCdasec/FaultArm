#include <stdio.h>
#include <stdbool.h>

void faultDetect() {}

int main()
{
	int i;
	for(i = 0; i < 10; i++){
		printf("i = %d\n", i);
	}

	if(i < 10){
		faultDetect();
	}

    return 0;
}
