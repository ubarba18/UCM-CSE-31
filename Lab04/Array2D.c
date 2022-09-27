#include <stdio.h>
#include <malloc.h>

void printArray(int**, int);

int main() {
	int i = 0, j = 0, n = 5;
	int **arr = (int**)malloc(n * sizeof(int*));

	// (3) Add your code to complete allocating and initializing the 2-D array here. The content should be all 0.

	for (i = 0; i < n; i ++) {
		*(arr + i) = (int *)malloc(n* sizeof(int*)); //allocate 5 arr rows
		for (j = 0; j < n; j++) {
			*(*(arr+i)+j) = 0;	//set each rows column = 0;
		}
	}

    // This will print out your array
	printArray(arr, n);

    // (6) Add your code to make arr a diagonal matrix
    
	for (i = 0; i < n; i++) {
		*(*(arr+i)+i) = i+1; //row 0 col 0 = 0+1, row 1 col 1 = 1+1, etc
	}
	
	// (7) Call printArray to print array
    printf("\n");
	printArray(arr, n);

	return 0;
}

void printArray(int ** array, int size) {
    // (5) Implement your printArr here:

	for (int i = 0; i < size; i ++) {
		for (int j = 0; j < size; j++) {
			printf("%d ", *(*(array+i)+j)); //print each row
		}
		printf("\n");
	}
}
