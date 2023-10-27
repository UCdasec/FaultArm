#include <stdio.h>

void encrypt(char *data, char key) {
    while (*data) {
        *data ^= key;
        data++;
    }
}

int main() {
    char message[] = "SensitiveData";
    char key = 0xAA;

    printf("Original message: %s\n", message);
    encrypt(message, key);
    printf("Encrypted message: %s\n", message);
    encrypt(message, key);
    printf("Decrypted message: %s\n", message);

    return 0;
}
