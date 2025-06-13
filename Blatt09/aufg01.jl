using LinearAlgebra
using PrettyTables

# Fakultät mit BigInt für große Zahlen
factbig(n) = factorial(big(n))

# Funktion zur expliziten Berechnung des Inversen-Eintrags der Hilbertmatrix
function hilbert_inverse_entry(i, j, n)
    i, j = BigInt(i), BigInt(j)
    nenner = (-1)^(i + j) * factbig(i + n - 1) * factbig(j + n - 1)
    zähler = (factbig(i - 1))^2 * (factbig(j - 1))^2 * factbig(n - i) * factbig(n - j) * (i + j - 1)
    return BigFloat(nenner) / BigFloat(zähler)
end

# Hilbertmatrix H^n in Float64
function hilbert_float(n)
    H = Matrix{Float64}(undef, n, n)
    for i in 1:n
        for j in 1:n
            H[i, j] = 1 / (i + j - 1)
        end
    end
    return H
end

# Erzeugung der Hilbertmatrix H^n in BigFloat
function hilbert(n)
    H = Matrix{BigFloat}(undef, n, n)
    for i in 1:n
        for j in 1:n
            H[i, j] = 1 / BigFloat(i + j - 1)
        end
    end
    return H
end

# Erzeugung der expliziten Inversenmatrix
function hilbert_inverse(n)
    H_inv = Matrix{BigFloat}(undef, n, n)
    for i in 1:n
        for j in 1:n
            H_inv[i, j] = BigFloat(hilbert_inverse_entry(i, j, n))
        end
    end
    return H_inv
end

# Berechnung der ∞-Norm von R_n = H * H⁻¹ - I
function compute_Rn_norm_explicit(n)
    H = hilbert(n)
    H_inv = hilbert_inverse(n)
    Rn = H * H_inv - I(n)
    return norm(Rn, Inf)
end

# Konditionszahl-Berechnung für alle 3 Methoden
function compute_condition_numbers(n)
    # Float64
    Hf = hilbert_float(n)
    Hf_inv = inv(Hf)
    κ_float = norm(Hf, Inf) * norm(Hf_inv, Inf)

    # BigFloat numerisch
    Hb = hilbert(n)
    Hb_inv = inv(Hb)
    κ_big_inv = norm(Hb, Inf) * norm(Hb_inv, Inf)

    # Analytisch
    Hb_inv_exact = hilbert_inverse(n)
    κ_analytic = norm(Hb, Inf) * norm(Hb_inv_exact, Inf)

    return (κ_float, κ_big_inv, κ_analytic)
end

# Werte für n
header1 = ["n", "||R_n||_∞"]
n_values = [5, 10, 20, 30]
table_data1 = zeros(Float64, length(n_values), 2)

header2 = ["n", "Float64", "BigFloat", "Analytisch"]
table_data2 = zeros(Float64, length(n_values), 4)

for (i, n) in enumerate(n_values)
    normRn = compute_Rn_norm_explicit(n)
    float, big, ana = compute_condition_numbers(n)
    table_data1[i, 1] = n
    table_data1[i, 2] = normRn
    table_data2[i, 1] = n
    table_data2[i, 2] = float
    table_data2[i, 3] = big
    table_data2[i, 4] = ana
end

pretty_table(table_data1; header=header1, formatters=ft_printf("%.4e", 2), title="Norm von R_n für verschiedene n", compact_printing = false, crop = :none)
pretty_table(table_data2; header=header2, formatters=ft_printf("%.4e", 2:4), title="Konditionszahl verschiedener Methoden", compact_printing = false, crop = :none)
