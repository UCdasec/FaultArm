#include <stdio.h>

// Structure to store calibration values
struct Calibration {
    float north;
    float south;
    float east;
    float west;
    float up;
    float down;
};

int main() {
    char choice;
    struct Calibration calibration;

    printf("Probe Calibration Program\n");

    // Ask the user whether to set or load calibration
    printf("Do you want to set calibration (S) or load calibration (L)? ");
    scanf(" %c", &choice);

    if (choice == 'S' || choice == 's') {
        // Set calibration values
        printf("Enter calibration values for:\n");
        printf("North: ");
        scanf("%f", &calibration.north);
        printf("South: ");
        scanf("%f", &calibration.south);
        printf("East: ");
        scanf("%f", &calibration.east);
        printf("West: ");
        scanf("%f", &calibration.west);
        printf("Up: ");
        scanf("%f", &calibration.up);
        printf("Down: ");
        scanf("%f", &calibration.down);

        // Store calibration values in a file
        FILE *file = fopen("calibration", "w");
        if (file == NULL) {
            printf("Error opening the calibration file for writing.\n");
            return 1;
        }
        fprintf(file, "%.2f %.2f %.2f %.2f %.2f %.2f", calibration.north, calibration.south, calibration.east, calibration.west, calibration.up, calibration.down);
        fclose(file);

        printf("Calibration values have been set and saved to the 'calibration' file.\n");
    } else if (choice == 'L' || choice == 'l') {
        // Load calibration values from a file
        FILE *file = fopen("calibration", "r");
        if (file == NULL) {
            printf("Error opening the calibration file for reading. Calibration values are not set.\n");
        } else {
            fscanf(file, "%f %f %f %f %f %f", &calibration.north, &calibration.south, &calibration.east, &calibration.west, &calibration.up, &calibration.down);
            fclose(file);

            printf("Loaded Calibration Values:\n");
            printf("North: %.2f\n", calibration.north);
            printf("South: %.2f\n", calibration.south);
            printf("East: %.2f\n", calibration.east);
            printf("West: %.2f\n", calibration.west);
            printf("Up: %.2f\n", calibration.up);
            printf("Down: %.2f\n", calibration.down);
        }
    } else {
        printf("Invalid choice. Please enter 'S' to set calibration or 'L' to load calibration.\n");
    }

    return 0;
}

