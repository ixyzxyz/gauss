/*
$ clang++ gauss.cpp -std=c++17 -O3 -o gauss
$ ./gauss
*/

#include <chrono>
#include <cstdio>

class Gauss {
  static const int n = 1000;
  double a[n][n] = {{}};
  double b[n] = {};
public:
  auto set(double a, double b) -> void {
    for (int i = 0; i < n; i++) {
      for (int j = i; j < n; j++) {
        this->a[i][j] = a;
      }
      this->b[i] = b;
    }
  }
  auto solve() -> void {
    for (int k = 0; k < n - 1; k++) {
      for (int i = k + 1; i < n; i++) {
        const double s = a[i][k] / a[k][k];
        for (int j = k + 1; j < n; j++) {
          a[i][j] -= s * a[k][j];
        }
        b[i] -= s * b[k];
      }
    }
    for (int i = n - 1; i >= 0; i--) {
      for (int j = i + 1; j < n; j++) {
        b[i] -= a[i][j] * b[j];
      }
      b[i] /= a[i][i];
    }
  }
  auto print() -> void {
    for (int i = 0; i < n; i++) {
      printf("x[%d] = %.10E\n", i, b[i]);
    }
  }
};

auto main() -> int {
  const auto gauss = new Gauss;
  gauss->set(1, 1);
  const auto start = std::chrono::system_clock::now();
  gauss->solve();
  const auto stop = std::chrono::system_clock::now();
  gauss->print();
  printf("%.6f%s\n", 0.000001 * std::chrono::duration_cast<std::chrono::microseconds>(stop - start).count(), "sec");
  delete gauss;
}