#include <stdio.h>

int foo(int *password) {
    *password += 1;
    // Simulate some complex password checking logic
    if (*password == 1) {
        return 0;  // Correct password
    } else {
        return 1;  // Incorrect password
    }
}

int main(void) {
    int password = (int)getchar();  // Dynamic pass

    // Call the function to check the password
    if (foo(&password) == 1) {
        printf("Access granted.\n");
    } else {
        printf("Access denied.\n");
        return 1;
    }

    return 0;
}

