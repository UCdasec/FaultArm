#include <stdio.h>

unsigned char calculate_checksum(char *data) {
    unsigned char checksum = 0;
    while (*data) {
        checksum += *data;
        data++;
    }
    return checksum;
}

int main() {
    char data[] = "IntegrityCheck";
    unsigned char checksum = calculate_checksum(data);

    printf("Data: %s\n", data);
    printf("Checksum: %u\n", checksum);

    return 0;
}
