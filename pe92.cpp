#include <iostream>
#include <vector>

std::vector<char> break_into_digits(int n) {
    std::vector<char> digits;
    while (n > 0) {
        digits.push_back(n % 10);
        n /= 10;
    }
    return digits;
}

int compute_chain_result(int i, std::vector<int>& chain_results) {
    if (chain_results[i] == 0) {
        int next_val = 0;
        std::vector<char> digits = break_into_digits(i);
        for (int digit : digits) {
            next_val += digit * digit;
        }
        chain_results[i] = compute_chain_result(next_val, chain_results);
    }
    return chain_results[i];
}

int main() {
    std::vector<int> result_table(10000001, 0);
    result_table[1] = 1;
    result_table[89] = 89;
    int eighty_nine_count = 0;
    for (unsigned int i = 1; i < result_table.size(); ++i) {
        if (compute_chain_result(i, result_table) == 89) {
            ++eighty_nine_count;
        }
    }
    std::cout << eighty_nine_count << std::endl;
    return 0;
}