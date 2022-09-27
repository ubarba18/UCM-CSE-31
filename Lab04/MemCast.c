#include <stdio.h>

int main() {
	int i;
	int four_ints[4];
	char* four_c;

	for(i = 0; i < 4; i++)
        four_ints[i] = 2;

	printf("%x\n", four_ints[0]);
	
    four_c = (char*)four_ints;

	for(i = 0; i < 4; i++)
        four_c[i] = 'A' + i; // ASCII value of 'A' is 65 or 0x41 in Hex.
    
    // Add your code for the exercises here:
	
	printf("%x\n", four_ints[1]);

	printf("four_ints address: %p\n" , four_ints);
	printf("four_c    address: %p\n", four_c);
	printf("\n");

	for(int i = 0; i < 4; i++){
		printf("four_ints[%d] address: %p value: %d \n", i, four_ints +i,*(four_ints + i));
	}

	for(int i = 0; i < 4; i++){
	printf("four_c[%d]    address: %p value: %d \n", i, four_c+i, *(four_c + i));
	}
	
	return 0;
}