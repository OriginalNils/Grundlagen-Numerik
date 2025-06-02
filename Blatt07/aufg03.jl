using LinearAlgebra
using Plots

# Parameter
c = 1.2
A = 3 * (c - 1)
K = 0.5 * sqrt(1 - 1 / c)
ε = 1e-3
Lx = 40
N = 100
max_iter = 1000
γ = 2.0

# Analytische Lösung
function analytical_solution(x, t)
    ξ = x .- c * t
    return A ./ cosh.(K .* ξ).^2
end

# Diskretisierter Laplace-Operator mit periodischen Randbedingungen
function laplace_matrix(N, dx)
    D = zeros(Float64, N, N)
    for i in 1:N
        D[i, i] = -2
        D[i, mod1(i+1, N)] = 1
        D[i, mod1(i-1, N)] = 1
    end
    return D / dx^2
end

# Modifizierte Fixpunktiteration mit Fehlerbehandlung und Fortschrittsausgabe
function modified_fixed_point(N)
    x = LinRange(-Lx/2, Lx/2, N+1)[1:end-1]
    dx = x[2] - x[1]
    D2 = laplace_matrix(N, dx)
    I = Matrix{Float64}(LinearAlgebra.I, N, N)
    L = (c - 1) * I - c * D2

    Φ0 = analytical_solution(x, 0)
    Φ = Φ0 .* (1 .+ ε)

    for i in 1:max_iter
        NΦ = 0.5 .* Φ.^2
        LΦ = L * Φ
        numerator = dot(LΦ, Φ)
        denominator = dot(NΦ, Φ)

        if abs(denominator) < 1e-14 || isnan(denominator) || isinf(denominator)
            println("Abbruch bei Iteration $i wegen ungültigem Nenner")
            break
        end

        mΦ = numerator / denominator

        if isnan(mΦ) || isinf(mΦ) || mΦ < 0
            println("Abbruch bei Iteration $i wegen ungültigem m(Φ) = $mΦ")
            break
        end

        Φ = (mΦ^γ) .* (L \ NΦ)

        if i % 100 == 0
            println("Iteration $i: m(Φ) = $(round(mΦ, digits=6)), ‖Φ‖_∞ = $(maximum(abs.(Φ)))")
        end
    end
    return x, Φ, Φ0
end

# Hauptlauf & Plot
x, Φ_num, Φ_exact = modified_fixed_point(N)

plot(x, Φ_num, label="Numerisch Φ₁₀₀₀", lw=2)
plot!(x, Φ_exact, label="Analytisch u(0,x)", lw=2, ls=:dash)
xlabel!("x")
ylabel!("Φ(x)")
title!("Vergleich: Modifizierte Fixpunktiteration (N = $N)")
