#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
 
// Declarations of the two functions you will implement
// Feel free to declare any helper functions or global variables
void printPuzzle(char** arr);
void searchPuzzle(char** arr, char* word);
void printGrid(int** grid);
bool checkLetter(char** arr, char* word, int i, int j, int index, int **grid);
int bSize; 

// Main function, DO NOT MODIFY    
int main(int argc, char **argv) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <puzzle file name>\n", argv[0]);
        return 2;
    }
    int i, j;
    FILE *fptr;
 
    // Open file for reading puzzle
    fptr = fopen(argv[1], "r");
    if (fptr == NULL) {
        printf("Cannot Open Puzzle File!\n");
        return 0;
    }
 
    // Read the size of the puzzle block
    fscanf(fptr, "%d\n", &bSize);
   
    // Allocate space for the puzzle block and the word to be searched
    char **block = (char**)malloc(bSize * sizeof(char*));
    char *word = (char*)malloc(20 * sizeof(char));
 
    // Read puzzle block into 2D arrays
    for(i = 0; i < bSize; i++) {
        *(block + i) = (char*)malloc(bSize * sizeof(char));
        for (j = 0; j < bSize - 1; ++j) {
            fscanf(fptr, "%c ", *(block + i) + j);            
        }
        fscanf(fptr, "%c \n", *(block + i) + j);
    }
    fclose(fptr);
 
    printf("Enter the word to search: ");
    scanf("%s", word);
   
    // Print out original puzzle grid
    printf("\nPrinting puzzle before search:\n");
    printPuzzle(block);
    
   
    // Call searchPuzzle to the word in the puzzle
    searchPuzzle(block, word);
   
    return 0;
}
 
void printPuzzle(char** arr) {
    // This function will print out the complete puzzle grid (arr).
    // It must produce the output in the SAME format as the samples
    // in the instructions.
    // Your implementation here...
 
    for (int i = 0; i < bSize; i++) {
        for (int j = 0; j < bSize; j++) {
            printf("%c ", *(*(arr + i) + j));
        }
        printf("\n");
    }
 
}
 
void printGrid(int** grid) {
    for (int i = 0; i < bSize; i++) {
        for (int j = 0; j < bSize; j++) {
            printf("%d \t", *(*(grid + i) + j));
        }
        printf("\n");
    }
 
}
 
void lowertoUpper (char* word) {
    for (int i = 0; *(word +i) !='\0'; i++) {
      if(*(word + i) >= 'a' && *(word + i) <= 'z') { //turns search word lower case letters to upper case
         *(word + i) = *(word + i) - 32;
      }
   }
}
 
bool checkLetter(char** arr, char* word, int i, int j, int index, int **grid) {
        index++;
       
        if (*(word + index) == '\0') {
            *(*(grid + i) +j) = *(*(grid + i) + j)*10 + index;
            return true;
        }
 
        if (i - 1 >= 0  && *(*(arr + i - 1) + j) == *(word + index)) { //Look at char above
            if(checkLetter(arr, word, i - 1, j, index, grid)){
            *(*(grid + i) + j) =  *(*(grid + i) + j)*10 + index;
             return true;
            }
        }
 
        if (i + 1 <= bSize - 1  && *(*(arr + i + 1) + j) == *(word + index)) { //Look at char under
            if(checkLetter(arr, word, i + 1, j, index, grid)){
            *(*(grid + i) + j) =  *(*(grid + i) + j)*10 + index; //
            return true;
            }
        }
 
        if(j - 1 >= 0  && *(*(arr + i) + j - 1) == *(word + index)) { //Look at char left
            if(checkLetter(arr, word, i, j - 1, index, grid)) {
            *(*(grid + i) + j) = *(*(grid + i) + j)*10 + index; //
            return true;
            }
        }
 
        if (j + 1 <= bSize -1  && *(*(arr + i) + j + 1) == *(word + index)) { //Look at char right
            if(checkLetter(arr, word, i, j + 1, index, grid)){
            *(*(grid + i) + j) =  *(*(grid + i) + j)*10 + index; //
            return true;
            }
        }
 
        if (j - 1 >= 0 && i - 1 >= 0  && *(*(arr + i - 1) + j - 1) == *(word + index)) { //Look at char top left
            if(checkLetter(arr, word, i - 1, j - 1, index, grid)){
            *(*(grid + i) + j) =  *(*(grid + i) + j)*10 + index; //
            return true;
            }
        }
 
        if (j + 1 <= bSize - 1 && i - 1 >= 0 && *(*(arr + i - 1) + j + 1) == *(word + index)) { //Look at char top right
            if(checkLetter(arr, word, i - 1, j + 1, index, grid)) {
            *(*(grid + i) + j) =  *(*(grid + i) + j)*10 + index; //
            return true;
            }
        }
 
        if (j - 1 >= 0 && i + 1 <= bSize - 1  && *(*(arr + i + 1) + j - 1) == *(word + index)) { //Look at char bottom left
            if(checkLetter(arr, word, i + 1, j - 1, index, grid))
            *(*(grid + i) + j) =  *(*(grid + i) + j)*10 + index; //
            return true;
        }
 
        if (j + 1 <= bSize - 1 && i + 1 <= bSize - 1 && *(*(arr + i + 1) + j + 1) == *(word + index)) { //Look at char bottom right
            if(checkLetter(arr, word, i + 1, j + 1, index, grid))
            *(*(grid + i) + j) =  *(*(grid + i) + j)*10 + index;// 0*10 + 6, 6*10 + 4, 64*10 + 2, 642
            return true;
        }
 
        return false;
 
}
 
void searchPuzzle(char** arr, char* word) {
    // This function checks if arr contains the search word. If the
    // word appears in arr, it will print out a message and the path
    // as shown in the sample runs. If not found, it will print a
    // different message as shown in the sample runs.
    // Your implementation here...
 
    lowertoUpper(word);

    int **grid = (int **)malloc(bSize * sizeof(int *));
    for (int i = 0; i < bSize; i ++) {
		*(grid + i) = (int *)malloc(bSize* sizeof(int*)); //allocate bSize grid
		for (int j = 0; j < bSize; j++) {
			*(*(grid + i) + j) = 0;	//set each row = 0;
		}
	}

    bool wordFound = false;
   
    for (int i = 0; i < bSize; i++) {
        for (int j = 0; j < bSize; j++)
 
        if (*(word) == *(*(arr + i) + j)) {
            if(checkLetter(arr, word, i, j, 0, grid)) {
            *(*(grid + i) + j) = 1; //starting point
            wordFound = true;
            }
           
        }
    }
 
 
    if (wordFound) {
        printf("\n"); //print newline
        printf("Word found!\n");
        printGrid(grid);
    }

    else{
    printf("\n"); //print newline
    printf("Word not found!");
    }
 
 
    //         if (strcmp (letters[i], *(*(arr + i)+j))) { //search left to right
 
    //         }
 
    //         if
    //     }
    // }
    // if (lettersFound) {
    //     printf("Word found!\n");
 
    // }
 
}
 
 
 
 
 
 
 
 
 

