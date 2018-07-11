#include <iostream>
#include <vector>
#include <cmath>

// checks if a number is `abundant`, i.e. if the sum of it's proper divisors
// is greater than the number
bool isAbundant(int n) {
    int properDivisorsSum = 1;
    for (int i = 2; i <= std::floor(std::sqrt(n)); ++i) {
        if (n % i == 0) {
            properDivisorsSum += i;
            if (i*i != n) {
                properDivisorsSum += (n/i);
            }
        }
    }
    return properDivisorsSum > n;
}

// constructs a vector of abundant numbers less than or equal
// to the input argument
std::vector<int> abundantNumsUpTo(int n) {
    std::vector<int> abundantNums {};
    for (int i = 12; i <= n; ++i) {
        if (isAbundant(i)) {
            abundantNums.push_back(i);
        }
    }
    return abundantNums;
}

int main() {
    std::vector<int> abuns = abundantNumsUpTo(28123);
    std::vector<bool> abundantSummable(28124, false);
    int abundantSumsSum = 0;
    for (int x : abuns) {
        for (int y : abuns) {
            if ((x+y > 28123) || abundantSummable[x+y]) { continue; }
            else {
                abundantSumsSum += (x+y);
                abundantSummable[x+y] = true;
            }
        }
    }
    int nonAbundantSumsSum = (28123*28124)/2 - abundantSumsSum;
    std::cout << nonAbundantSumsSum << '\n';
    return 0;
}