#include <stdio.h>
#include <stdlib.h>
#include <time.h>

// Function to create and update the plot file
void updatePlotFile(double time, double value) {
    FILE *file = fopen("plot_data.dat", "a");
    if (file == NULL) {
        printf("Error opening the plot data file.\n");
        exit(1);
    }
    fprintf(file, "%.2lf %.2lf\n", time, value);
    fclose(file);
}

int main() {
    double value;
    time_t startTime, currentTime;
    char choice;

    // Create or overwrite the plot data file
    FILE *file = fopen("plot_data.dat", "w");
    if (file == NULL) {
        printf("Error opening the plot data file.\n");
        return 1;
    }
    fclose(file);

    printf("Continuous X-Y Plot Generator\n");

    do {
        printf("Enter a value (or 'q' to quit): ");
        if (scanf("%lf", &value) != 1) {
            scanf("%c", &choice);  // Clear the input buffer
            if (choice == 'q' || choice == 'Q') {
                break;  // Exit the loop if the user enters 'q'
            } else {
                printf("Invalid input. Please enter a numeric value.\n");
                continue;
            }
        }

        // Get the current time
        currentTime = time(NULL);

        // Calculate the time elapsed since the program started
        if (startTime == 0) {
            startTime = currentTime;
        }
        double elapsedTime = difftime(currentTime, startTime);

        // Update the plot file
        updatePlotFile(elapsedTime, value);

        // Print the value and time
        printf("Time: %.2lf seconds, Value: %.2lf\n", elapsedTime, value);

    } while (1);

    printf("Exiting the program.\n");

    return 0;
}

