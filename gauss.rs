/*
$ rustc gauss.rs -O -o gauss
$ ./gauss
*/

fn main() {
  let mut gauss = Gauss::new(1000);
  gauss.set(1.0, 1.0);
  let start = std::time::Instant::now();
  gauss.solve();
  let stop = std::time::Instant::now();
  gauss.print();
  println!("{:.6}sec", 0.000000001 * (stop - start).as_nanos() as f64);
}

struct Gauss {a:Vec<Vec<f64>>, b:Vec<f64>}

impl Gauss {
  fn new(n:usize) -> Self {
    let a = vec![vec![0.0; n]; n];
    let b = vec![0.0; n];
    return Self {a, b};
  }
  fn set(&mut self, a:f64, b:f64) {
    let n = self.a.len();
    for i in 0 .. n {
      for j in i .. n {
        self.a[i][j] = a;
      }
      self.b[i] = b;
    }
/*
    self.a = vec![vec![1.0, 1.0, 1.0, 1.0, 1.0], vec![0.0, 1.0, 1.0, 1.0, 1.0], vec![0.0, 0.0, 1.0, 1.0, 1.0], vec![0.0, 0.0, 0.0, 1.0, 1.0], vec![0.0, 0.0, 0.0, 0.0, 1.0]];
    self.b = vec![1.0, 1.0, 1.0, 1.0, 1.0];
*/
  }
  fn solve(&mut self) {
    let n = self.a.len();
    for k in 0 .. n - 1 {
      for i in k + 1 .. n {
        let s = self.a[i][k] / self.a[k][k];
        for j in k + 1 .. n {
          self.a[i][j] -= s * self.a[k][j];
        }
        self.b[i] -= s * self.b[k];
      }
    }
    for i in (0 .. n).rev() {
      for j in i + 1 .. n {
        self.b[i] -= self.a[i][j] * self.b[j];
      }
      self.b[i] /= self.a[i][i];
    }
  }
  fn print(&self) {
    for i in 0 .. self.b.len() {
      println!("x[{}] = {:.10E}", i, self.b[i]);
    }
  }
}