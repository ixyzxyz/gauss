/*
$ javac gauss.java
$ java Main
*/

class Main {
  public static void main(String... args) {
    final Gauss gauss = new Gauss(1000);
    gauss.set(1, 1);
    final long start = System.nanoTime();
    gauss.solve();
    final long stop = System.nanoTime();
    gauss.print();
    System.out.printf("%.6f%s\n", 0.000000001 * (stop - start), "sec");
  }
}

class Gauss {
  final int n;
  double[][] a;
  double[] b;
  Gauss(int n) {
    this.n = n;
    a = new double[n][n];
    b = new double[n];
  }
  void set(double a, double b) {
    for (int i = 0; i < n; i++) {
      for (int j = i; j < n; j++) {
        this.a[i][j] = a;
      }
      this.b[i] = b;
    }
/*
    a[0][0] = 1; a[0][1] = 1; a[0][2] = 1; a[0][3] = 1; a[0][4] = 1; b[0] = 1;
    a[1][0] = 0; a[1][1] = 1; a[1][2] = 1; a[1][3] = 1; a[1][4] = 1; b[1] = 1;
    a[2][0] = 0; a[2][1] = 0; a[2][2] = 1; a[2][3] = 1; a[2][4] = 1; b[2] = 1;
    a[3][0] = 0; a[3][1] = 0; a[3][2] = 0; a[3][3] = 1; a[3][4] = 1; b[3] = 1;
    a[4][0] = 0; a[4][1] = 0; a[4][2] = 0; a[4][3] = 0; a[4][4] = 1; b[4] = 1;
*/
  }
  void solve() {
    for (int k = 0; k < n - 1; k++) {
      for (int i = k + 1; i < n; i++) {
        final double s = a[i][k] / a[k][k];
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
  void print() {
    for (int i = 0; i < b.length; i++) {
      System.out.printf("x[%d] = %.10E\n", i, b[i]);
    }
  }
}