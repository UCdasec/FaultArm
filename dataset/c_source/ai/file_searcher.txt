#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <dirent.h>
#include <time.h>
#include <pwd.h>

void search_files(const char *path) {
    DIR *dir;
    struct dirent *entry;
    struct stat st;
    struct passwd *pwd;
    char fullpath[PATH_MAX];

    if ((dir = opendir(path)) == NULL) {
        perror("opendir");
        return;
    }

    while ((entry = readdir(dir)) != NULL) {
        if (strcmp(entry->d_name, ".") == 0 || strcmp(entry->d_name, "..") == 0) {
            continue;
        }

        snprintf(fullpath, sizeof(fullpath), "%s/%s", path, entry->d_name);

        if (lstat(fullpath, &st) == -1) {
            perror("lstat");
            continue;
        }

        // Print information about the file
        printf("Name: %s\n", entry->d_name);
        printf("Path: %s\n", fullpath);
        printf("Size: %ld bytes\n", (long)st.st_size);

        struct tm *created_time = localtime(&st.st_ctime);
        printf("Created: %s", asctime(created_time));

        struct tm *access_time = localtime(&st.st_atime);
        printf("Last Accessed: %s", asctime(access_time));

        struct tm *modified_time = localtime(&st.st_mtime);
        printf("Last Modified: %s", asctime(modified_time));

        // Retrieve author (owner) name
        pwd = getpwuid(st.st_uid);
        if (pwd != NULL) {
            printf("Author: %s\n", pwd->pw_name);
        } else {
            printf("Author: Unknown\n");
        }

        printf("Description: [Description not implemented]\n");

        if (S_ISDIR(st.st_mode)) {
            printf("Type: Directory\n\n");
            search_files(fullpath);  // Recursively search directories
        } else if (S_ISREG(st.st_mode)) {
            printf("Type: Regular File\n\n");
        } else {
            printf("Type: Unknown\n\n");
        }
    }

    closedir(dir);
}

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <search_directory>\n", argv[0]);
        return 1;
    }

    const char *search_directory = argv[1];
    printf("Searching in: %s\n\n", search_directory);

    search_files(search_directory);

    return 0;
}

