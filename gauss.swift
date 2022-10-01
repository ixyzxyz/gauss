/*
$ swiftc gauss.swift -O -o gauss
$ ./gauss
*/

import Foundation

class Gauss {
  let n:Int
  var a:[[Double]]
  var b:[Double]
  init(n:Int) {
    self.n = n
    a = [[Double]](repeating:[Double](repeating:0, count:n), count:n)
    b = [Double](repeating:0, count:n)
  }
  func set(a:Double, b:Double) {
    for i in 0 ..< n {
      for j in i ..< n {
        self.a[i][j] = a
      }
      self.b[i] = b
    }
/*
    self.a = [[1, 1, 1, 1, 1], [0, 1, 1, 1, 1], [0, 0, 1, 1, 1], [0, 0, 0, 1, 1], [0, 0, 0, 0, 1]]
    self.b = [1, 1, 1, 1, 1]
*/
  }
  func solve() {
    let a = self.a.withUnsafeMutableBufferPointer { $0 }
    let b = self.b.withUnsafeMutableBufferPointer { $0 }
    for k in 0 ..< n - 1 {
      for i in k + 1 ..< n {
        let s = a[i][k] / a[k][k]
        for j in k + 1 ..< n {
          a[i][j] -= s * a[k][j]
        }
        b[i] -= s * b[k]
      }
    }
    for i in (0 ..< n).reversed() {
      for j in i + 1 ..< n {
        b[i] -= a[i][j] * b[j]
      }
      b[i] /= a[i][i]
    }
  }
  func printf() {
    for i in 0 ..< b.count {
      print("x[\(i)] = \(String(format:"%.10E", b[i]))")
    }
  }
}

let gauss = Gauss(n:1000)
gauss.set(a:1, b:1)
let start = clock()
gauss.solve()
let stop = clock()
gauss.printf()
print("\(String(format:"%.6f", 0.000001 * Double(stop - start)))sec")