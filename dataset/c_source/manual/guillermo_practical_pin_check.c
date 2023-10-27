#include <stdio.h>

#define SIZE 6

int import_data(char *data);
int verify_pin(const char *input, const char *stored_pin);

int main(int argc, char** argv)
{
    char buf[SIZE];
    char existing_pin[SIZE];

    // Simulate importing data from memory
    if (import_data(existing_pin) == 1)
    {
        printf("Failed to import data\n");
        return 1;
    }

    // Simulate input from pad/device and validate
    if (scanf("%5s", buf) < 5)
    {
        // Failed
        printf("Bad input...\n");
        return 1;
    }

    if (verify_pin(buf, existing_pin) == 1)
    {
        printf("Incorrect PIN\n");
        return 1;
    }

}

int import_data(char *data)
{
    // Simulate local search
    FILE *fp = fopen("/path/to/saved/pins", "r");

    if (fp == NULL) return 1;

    if (fscanf(fp, "%5s", data) < 4) return 1;

    return 0;
}

int verify_pin(const char *input, const char *stored_pin)
{
    // Iterate through each character in the strings
    while (*input && *stored_pin) {
        // Compare individual characters
        if (*input != *stored_pin) {
            return 0;  // Strings are not equal
        }
        // Move to the next character
        input++;
        stored_pin++;
    }
    // Ensure both strings have reached their end
    return (*input == '\0' && *stored_pin == '\0');
}