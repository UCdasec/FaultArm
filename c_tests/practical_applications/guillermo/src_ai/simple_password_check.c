#include <stdio.h>
#include <string.h>

int check_password(const char *password) {
    const char *correct_password = "secure123";
    return strcmp(password, correct_password) == 0;
}

int main() {
    char input_password[50];
    printf("Enter password: ");
    scanf("%49s", input_password);

    if (check_password(input_password)) {
        printf("Access granted.\n");
    } else {
        printf("Access denied.\n");
    }

    return 0;
}
