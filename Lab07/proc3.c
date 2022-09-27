#include<stdio.h>

int bar(int a, int b, int c) {
    return c - a << b; // 6 - 5 = 1, 1 << 7 = 128 | 6 - (-2) = 8, 8 << 1 = 16
}

int foo(int m, int n, int o) {
    int p = bar(m + n, n + o, o + m); //bar(5, 7, 6) = 128
    int q = bar(m - o, n - m, 2 * n); //bar(-2, 1, 6) = 16
    return p + q; //144
}

int main() {
    int x = 2, y = 3, z = 4;
    z = x + y + z + foo(x, y, z); // 9  + 144 = 153
    printf("%d\n", z);
    return 0;
}
