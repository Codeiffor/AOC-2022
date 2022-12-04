#include <bits/stdc++.h>

int main() {
    int s1, e1, s2, e2;
    int count = 0;
    int count2 = 0;
    while (scanf("%d-%d,%d-%d\n", &s1, &e1, &s2, &e2) != EOF) {
      if ((s2 >= s1 && e2 <= e1) || (s1 >= s2 && e1 <= e2)) {
        count++;
      }
      if (!(e1 < s2 || e2 < s1)) {
        count2++;
      }
    }
    printf("first=%d\nsecond=%d\n", count, count2);
    return 0;
}