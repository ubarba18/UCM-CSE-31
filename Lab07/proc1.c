#include<stdio.h>
int sum (int m, int n){
	int sum = 0;

	sum = (m + n);
    
	return sum;
}
int main( ) {
	int m = 10;
	int n = 5;
	
	printf("%d", sum(m,n));
	
}