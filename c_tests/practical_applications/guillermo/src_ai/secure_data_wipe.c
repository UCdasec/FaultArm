#include <stdio.h>
#include <string.h>

void secure_wipe(char *data, size_t size) {
    for (size_t i = 0; i < size; ++i) {
        data[i] = 0;
    }
}

int main() {
    char sensitive_data[] = "VerySecret";
    printf("Before wipe: %s\n", sensitive_data);
    secure_wipe(sensitive_data, strlen(sensitive_data));
    printf("After wipe: %s\n", sensitive_data);

    return 0;
}
