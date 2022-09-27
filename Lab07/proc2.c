#include<stdio.h>

int sub(int a) {
    int b = 2;
    return a - b; //20 - 2
}

int sum(int n) {
    int m = 15;
    return n + sub(m + n); //5 + sub(20) = 5 + 18 = 23
}

int main() {
    int x = 5, y = 10;

    y = y + x + sum(x); //15 + 23 = 38

    printf("%d\n", y);
    return 0;
}
