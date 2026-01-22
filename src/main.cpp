#include <iostream>
#include <vector>

int main() {
    std::cout << "Hello from C++17 sample\n";
    std::vector<int> v{1,2,3};
    for (int x : v) std::cout << x << ' ';
    std::cout << '\n';
    return 0;
}
