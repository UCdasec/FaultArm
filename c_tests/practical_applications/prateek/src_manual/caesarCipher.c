#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_FILE_SIZE 10000

void caesarCipher(char* text, int shift) {
    int i;
    for (i = 0; text[i] != '\0'; i++) {
        if (text[i] >= 'A' && text[i] <= 'Z') {
            text[i] = (text[i] - 'A' + shift) % 26 + 'A';
        }
    }
}

int main() {
    int shift;
    char text[MAX_FILE_SIZE];

    // Open the input file for reading
    FILE* file = fopen("text.txt", "r");

    if (file == NULL) {
        printf("Unable to open the file.\n");
        return 1;
    }

    // Read the content of the file
    if (fgets(text, sizeof(text), file) == NULL) {
        printf("Unable to read from the file.\n");
        fclose(file);
        return 1;
    }

    fclose(file);

    // Prompt the user for the Caesar cipher shift value
    printf("Enter the Caesar cipher shift value: ");
    scanf("%d", &shift);

    // Encrypt the text with Caesar cipher
    caesarCipher(text, shift);

    // Print the encrypted text
    printf("Caesar Cipher: %s\n", text);

    return 0;
}

