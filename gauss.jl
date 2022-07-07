#=
$ julia gauss.jl
=#

using Printf

struct Gauss
  a::Vector{Vector{Float64}}
  b::Vector{Float64}
  #Gauss(n) = new([zeros(Float64, n) for i = 1 : n], zeros(Float64, n))
#=
  function Gauss(n::Int)
    a = [zeros(Float64, n) for i = 1 : n]
    b = zeros(Float64, n)
    new(a, b)
  end
=#
end

function Gauss(n::Int)
  a = [zeros(Float64, n) for i = 1 : n]
  b = zeros(Float64, n)
  Gauss(a, b)
end

function set!(gauss::Gauss, a::Float64, b::Float64)
  n = length(gauss.a)
  for i = 1 : n
    for j = i : n
      gauss.a[i][j] = a
    end
    gauss.b[i] = b
  end
end

function solve!(gauss::Gauss)
  n = length(gauss.a)
  for k = 1 : n - 1
    for i = k + 1 : n
      s = gauss.a[i][k] / gauss.a[k][k]
      for j = k + 1 : n
        gauss.a[i][j] -= s * gauss.a[k][j]
      end
      gauss.b[i] -= s * gauss.b[k]
    end
  end
  for i = n : - 1 : 1
    for j = i + 1 : n
      gauss.b[i] -= gauss.a[i][j] * gauss.b[j]
    end
    gauss.b[i] /= gauss.a[i][i]
  end
end

function print(gauss::Gauss)
  for i = 1 : length(gauss.b)
    @printf("x[%d] = %.10E\n", i, gauss.b[i])
  end
end

const gauss = Gauss(1000)
set!(gauss, 1.0, 1.0)
@time begin
  solve!(gauss)
end
#print(gauss)