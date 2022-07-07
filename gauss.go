/*
$ go build -o gauss gauss.go
$ ./gauss
*/

package main
import "fmt"
import "time"

func main() {
  gauss := newGauss(1000)
  gauss.set(1, 1)
  start := time.Now()
  gauss.solve()
  stop := time.Now()
  gauss.print()
  fmt.Printf("%.6fsec\n", (stop.Sub(start)).Seconds())
}

type Gauss struct {
  a [][]float64
  b []float64
}

func newGauss(n int) *Gauss {
  a := make([][]float64, n)
  for i := range a {
    a[i] = make([]float64, n)
  }
  b := make([]float64, n)
/*
  a := [][]float64{{1, 1, 1, 1, 1}, {0, 1, 1, 1, 1}, {0, 0, 1, 1, 1}, {0, 0, 0, 1, 1}, {0, 0, 0, 0, 1}}
  b := []float64{1, 1, 1, 1, 1}
*/
  return &Gauss{a, b}
}

func (self *Gauss) set(a float64, b float64) {
  n := len(self.a)
  for i := 0; i < n; i++ {
    for j := i; j < n; j++ {
      self.a[i][j] = a
    }
    self.b[i] = b
  }
}

func (self *Gauss) solve() {
  n := len(self.a)
  for k := 0; k < n - 1; k++ {
    for i := k + 1; i < n; i++ {
      s := self.a[i][k] / self.a[k][k]
      for j := k + 1; j < n; j++ {
        self.a[i][j] -= s * self.a[k][j]
      }
      self.b[i] -= s * self.b[k]
    }
  }
  for i := n - 1; i >= 0; i-- {
    for j := i + 1; j < n; j++ {
      self.b[i] -= self.a[i][j] * self.b[j]
    }
    self.b[i] /= self.a[i][i]
  }
}

func (self *Gauss) print() {
  for i := range self.b {
    fmt.Printf("x[%d] = %.10E\n", i, self.b[i])
  }
}