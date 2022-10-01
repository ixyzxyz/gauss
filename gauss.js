/*
$ node gauss.js
*/

"use strict";
const performance = require("perf_hooks").performance;

class Gauss {
  constructor(n) {
    this.a = Array(n).fill().map(() => new Float64Array(n).fill(0));
    this.b = new Float64Array(n).fill(0);
  }
  set(a, b) {
    const n = this.a.length;
    for (let i = 0; i < n; i++) {
      for (let j = i; j < n; j++) {
        this.a[i][j] = a;
      }
      this.b[i] = b;
    }
  }
  solve() {
    const n = this.a.length;
    for (let k = 0; k < n - 1; k++) {
      for (let i = k + 1; i < n; i++) {
        const s = this.a[i][k] / this.a[k][k];
        for (let j = k + 1; j < n; j++) {
          this.a[i][j] -= s * this.a[k][j];
        }
        this.b[i] -= s * this.b[k];
      }
    }
    for (let i = n - 1; i >= 0; i--) {
      for (let j = i + 1; j < n; j++) {
        this.b[i] -= this.a[i][j] * this.b[j];
      }
      this.b[i] /= this.a[i][i];
    }
  }
  print() {
    for (const i in this.b) {
      console.log(`x[${i}] = ${this.b[i].toExponential(10)}`);
    }
  }
}

const gauss = new Gauss(1000);
gauss.set(1, 1);
const start = performance.now();
gauss.solve();
const stop = performance.now();
gauss.print();
console.log(`${(0.001 * (stop - start)).toFixed(6)}sec`);