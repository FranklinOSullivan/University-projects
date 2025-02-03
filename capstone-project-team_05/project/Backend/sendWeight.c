#include <stdio.h>
#include <curl/curl.h>
#include <string.h>
#include <stdlib.h>

char* parseEnvFile(const char* filename) {
    FILE* file = fopen(filename, "r");
    if (file == NULL) {
        fprintf(stderr, "Error: Unable to open file %s\n", filename);
        return NULL;
    }

    // Find out file size
    fseek(file, 0, SEEK_END);
    long file_size = ftell(file);
    fseek(file, 0, SEEK_SET);

    // Allocate memory to hold file contents
    char* file_contents = (char*)malloc(file_size + 1);
    if (file_contents == NULL) {
        fclose(file);
        fprintf(stderr, "Error: Memory allocation failed.\n");
        return NULL;
    }

    // Read file contents into memory
    size_t bytesRead = fread(file_contents, 1, file_size, file);
    file_contents[bytesRead] = '\0'; // Null-terminate the string

    fclose(file);

    // Format the API key string
    char* formatted_api_key = (char*)malloc(strlen(file_contents) + strlen("x-api-key: ") + 1);
    if (formatted_api_key == NULL) {
        free(file_contents);
        fprintf(stderr, "Error: Memory allocation failed.\n");
        return NULL;
    }
    sprintf(formatted_api_key, "x-api-key: %s", file_contents);

    // Free the memory allocated for the file contents
    free(file_contents);

    return formatted_api_key;
}

void sendWeight(double weight) {
    CURL *curl;
    CURLcode res;
    
    // Initialize libcurl
    curl_global_init(CURL_GLOBAL_ALL);
    curl = curl_easy_init();
    
    if(curl) {
        printf("beginning transmit\n");

        // Set URL
        curl_easy_setopt(curl, CURLOPT_URL, "http://localhost:3000/scale/upload/weight");

        // Set request headers
        struct curl_slist *headers = NULL;
        char* api_key = parseEnvFile(".env");
        printf("%s\n", api_key);
        char header[100]; // Assuming API key won't be longer than 100 characters
        snprintf(header, sizeof(header), "x-api-key: %s", api_key);
        headers = curl_slist_append(headers, header);
        headers = curl_slist_append(headers, "Content-Type: application/json");

        curl_easy_setopt(curl, CURLOPT_HTTPHEADER, headers);

        // Set POST data
        char post_data[100]; // Assuming weight won't be longer than 100 characters
        snprintf(post_data, sizeof(post_data), "{\"weight\": \"%f\"}", weight);
        curl_easy_setopt(curl, CURLOPT_POSTFIELDS, post_data);

        // Perform the request
        res = curl_easy_perform(curl);

        // Check for errors
        if(res != CURLE_OK)
            fprintf(stderr, "curl_easy_perform() failed: %s\n",
                    curl_easy_strerror(res));

        // Clean up
        curl_easy_cleanup(curl);
        curl_slist_free_all(headers);
    }
    
    curl_global_cleanup();
}