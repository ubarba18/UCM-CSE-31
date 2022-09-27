#include <stdio.h> 
 
 int main() { 
    int x , y, *px, *py; 
    int arr[10]; 
 
   printf("x: %d, y: %d, arr[0]: %d \n", x, y, arr[0]);

   printf("Address of x = %p,  Address of y = %p\n", &x, &y);
   printf("\n");
   px = &x, py = &y;
   printf("Address of px = %p,  Address of py = %p\n", &px, &py);
   printf("Value of px = %d, Value of py = %d\n", *px , *py);
   printf("\n");

   for (int i = 0; i < 10; i++) {
      printf("Address of arr index %d: %p\n", i, &*(arr + i));
   }

   printf("address arr[0] = %p, address arr = %p\n", &arr[0], &arr);
   printf("arr[0] = %p, arr = %p\n", &arr[0], arr);
   printf("arr: %d, arr[0]: %d", *arr, arr[0]);

  return 0; 
 } 