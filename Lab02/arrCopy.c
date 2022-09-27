#include<stdio.h>
#include<string.h>
#include<stdlib.h>

void printArr(int *a, int size, char *name){ //pass in original arr, its size, and a str "Original"

    printf("\n");
    printf("%s array's contents: ", name);
	for (int i = 0; i < size; i++) {
        printf("%d ", *(a + i));
    }
}

int* arrCopy(int *a, int size){ //pass in original arr and n
	int *copied = (int*) malloc(size * sizeof(int));
    int j = size;

    for (int i = 0; i < size; i++) { //copieds first is originals last
        j--;
        *(copied + i) = *(a + j);

    }
    return copied;
}

int main(){
    int n;
    int *arr;
    int *arr_copy;
    int i;
    printf("Enter the size of array you wish to create: ");
    scanf("%d", &n);

    //Dynamically create an int array of n items
    arr = (int*) malloc(n * sizeof(int)); //(n * 4bytes)

    //Ask user to input content of array
	for (i = 0; i < n; i++) {
        printf("Enter array element #%d: ", i + 1);
        scanf("%d", (arr + i));
    }
	
/*************** YOU MUST NOT MAKE CHANGES BEYOND THIS LINE! ***********/
	
	//Print original array
    printArr(arr, n, "Original");

	//Copy array with contents in reverse order
    arr_copy = arrCopy(arr, n);

	//Print new array
    printArr(arr_copy, n, "Copied");

    printf("\n");

    return 0;
}