"""
$ python gauss.py
"""
import numpy as np
import time

class Gauss:
  #n = np.int64(1000)
  #a = np.zeros((n, n), dtype=np.float64)
  #b = np.zeros(n, dtype=np.float64)
  def __init__(self):
    Gauss.n = 1000
    self.a = np.zeros((Gauss.n, Gauss.n))
    self.b = np.zeros(Gauss.n)
  def set(self, a, b):
    for i in range(Gauss.n):
      for j in range(i, Gauss.n):
        self.a[i][j] = a
      self.b[i] = b
    #self.a = [[1, 1, 1, 1, 1], [0, 1, 1, 1, 1], [0, 0, 1, 1, 1], [0, 0, 0, 1, 1], [0, 0, 0, 0, 1]]
    #self.b = [1, 1, 1, 1, 1]
  def solve(self):
    for k in range(Gauss.n - 1):
      for i in range(k + 1, Gauss.n):
        s = self.a[i][k] / self.a[k][k]
        for j in range(k + 1, Gauss.n):
          self.a[i][j] -= s * self.a[k][j]
        self.b[i] -= s * self.b[k]
    for i in range(Gauss.n - 1, - 1, - 1):
      for j in range(i + 1, Gauss.n):
        self.b[i] -= self.a[i][j] * self.b[j]
      self.b[i] /= self.a[i][i]
  def print(self):
    for i in range(len(self.b)):
      print(f"x[{i}] = {self.b[i]:.10E}")

gauss = Gauss()
gauss.set(1, 1)
start = time.time()
gauss.solve()
stop = time.time()
gauss.print()
print(f"{(stop - start):.6f}sec")