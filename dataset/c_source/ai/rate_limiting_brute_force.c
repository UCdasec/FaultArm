#include <stdio.h>
#include <string.h>
#include <unistd.h>

int check_password(const char *password) {
    const char *correct_password = "secure123";
    return strcmp(password, correct_password) == 0;
}

int main() {
    char input_password[50];
    int attempts = 0;

    while (attempts < 3) {
        printf("Enter password: ");
        scanf("%49s", input_password);

        if (check_password(input_password)) {
            printf("Access granted.\n");
            return 0;
        } else {
            printf("Access denied.\n");
            attempts++;
            sleep(1);  // Simulate delay to prevent brute-force
        }
    }

    printf("Too many incorrect attempts.\n");
    return 1;
}
