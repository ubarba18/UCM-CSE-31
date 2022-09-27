
#include <stdio.h>
#include <malloc.h>

int** matMult(int **a, int **b, int size) {
	// (4) Implement your matrix multiplication here. You will need to create a new matrix to store the product.

	int **matD = (int**)malloc(size * sizeof(int*));
	int sum = 0;
	for(int i = 0; i < size; i++){
		*(matD + i) = (int *)malloc(size * sizeof(int)); //allocate 5 arr column
		for(int j = 0; j < size; j++){
			sum = 0;
			for(int k = 0; k < size; k++) {
				sum += *(*(a + i) + k) * *(*(b + k) + j); //multiply matrixA col by MatrixB row, matrixA col 0 * matrixB row 0 (5*3) + matrixA row 0 * matrixB col 1
			}
			*(*(matD + i) + j) = sum; //row 0 col 0;
		}
	}

	return matD;
}

void printArray(int **arr, int n) {
	// (2) Implement your printArray function here

	for (int i = 0; i < n; i ++) {
		for (int j = 0; j < n; j++) {
			printf("%d ", *(*(arr+i)+j)); //prints row 0 and all columns, prints row 1 all columns
		}
		printf("\n");
	}
}

int main() {
	int n = 0;
	int **matA, **matB, **matC;
	// (1) Define 2 (n x n) arrays (matrices). 

	printf("Input n size to create the n x n matrix: ");
	scanf("%d", &n);

	matA = (int**)malloc(n * sizeof(int*));
	for (int i = 0; i < n; i ++) {
		*(matA + i) = (int *)malloc(n* sizeof(int*)); //allocate 5 arr column
		for (int j = 0; j < n; j++) {
			scanf("%d", &*(*(matA+i)+j));
		}
	}
	
	matB = (int**)malloc(n * sizeof(int*));
	for (int i = 0; i < n; i ++) {
		*(matB + i) = (int *)malloc(n* sizeof(int*)); //allocate 5 arr column
		for (int j = 0; j < n; j++) {
			scanf("%d", &*(*(matB+i)+j));
		}
	}
	// (3) Call printArray to print out the 2 arrays here.
	
	printArray(matA, n);
	printArray(matB, n);
	
	// (5) Call matMult to multiply the 2 arrays here.
	
	matC = matMult(matA, matB, n);
	
	// (6) Call printArray to print out resulting array here.

	printArray(matC, n);
    return 0;
}