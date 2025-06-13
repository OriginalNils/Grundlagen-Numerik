using LinearAlgebra
using BenchmarkTools
using PrettyTables

eps_float64 = eps(Float64)
ε = 4 * eps_float64

dimensions = [5, 10, 20, 50, 100, 150, 200, 300, 500, 1000, 3000]

function kahan_matrix(n, ε)
    K = Matrix{Float64}(I, n, n)
    for i in 1:n
        for j in (i+1):n
            K[i, j] = ε^(j - i)
        end
    end
    return K
end

function rhs_vector(n)
    return collect(1.0:n)
end

# Rückwärtssubstitution für obere Dreiecksmatrix Kx=b
function backward_substitution(K, b)
    n = length(b)
    x = zeros(Float64, n)
    for i in n:-1:1
        s = 0.0
        for j in (i+1):n
            s += K[i, j] * x[j]
        end
        x[i] = (b[i] - s) / K[i, i]
    end
    return x
end

header = ["n", "Gauß Zeit", "Inverse Zeit"]
table_data = zeros(Float64, length(dimensions), 3)

for (i,n) in enumerate(dimensions)
    K = kahan_matrix(n, ε)
    b = rhs_vector(n)

    # Zeit Gauß (Rückwärtssubstitution, da obere Dreiecksmatrix)
    # Da K schon obere Dreiecksmatrix, Gauß ist nur Rückwärtssubstitution
    t_gauss = @belapsed backward_substitution($K, $b)

    # Zeit inv(K)*b
    t_inv = @belapsed inv($K) * $b

    table_data[i, 1] = n
    table_data[i, 2] = t_gauss
    table_data[i, 3] = t_inv
end

pretty_table(table_data; header=header, formatters=ft_printf("%.4e", 2:3), title="Zeit Berechnung über Gauß/Inverse", compact_printing = false, crop = :none)
