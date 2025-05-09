using LinearAlgebra
using Random
using PrettyTables

function thomas_algorithm(l, d, u, b)
    n = length(b)
    up = copy(u)
    bp = copy(b)

    for i in 2:n
        m = l[i] / d[i-1]
        d[i] -= m * up[i-1]
        bp[i] -= m * bp[i-1]
    end

    x = zeros(n)
    x[n] = bp[n] / d[n]
    for i in n-1:-1:1
        x[i] = (bp[i] - up[i] * x[i+1]) / d[i]
    end

    return x
end

function thomas_algorithm_matrix(A::Matrix{Float64}, b::Vector{Float64})
    n = size(A, 1)
    l = zeros(n)
    d = zeros(n)
    u = zeros(n)

    # Extrahiere die Diagonalen
    for i in 1:n
        d[i] = A[i, i]
        if i > 1
            l[i] = A[i, i-1]
        end
        if i < n
            u[i] = A[i, i+1]
        end
    end

    # Thomas-Algorithmus aufrufen
    return thomas_algorithm(l, d, u, b)
end


function test_thomas_vs_builtin()
    ns = [5, 10, 20, 50, 100]
    table_data = zeros(Float64, length(ns), 2)

    for (i, n) in enumerate(ns)
        Random.seed!(42)  # Reproduzierbarkeit
        l = [0.0; rand(n-1) .+ 1]      # untere Diagonale
        d = rand(n) .+ 2               # Hauptdiagonale (dominant)
        u = [rand(n-1) .+ 1; 0.0]      # obere Diagonale
        b = rand(n)                    # rechte Seite

        # Vollständige Matrix konstruieren
        A = diagm(-1 => l[2:end], 0 => d, 1 => u[1:end-1])

        # Lösung mit Thomas
        x_thomas = thomas_algorithm(l, d, u, b)

        # Lösung mit Julia
        x_builtin = A \ b

        # Fehler
        err = norm(x_thomas - x_builtin, Inf)
        table_data[i, 1] = n
        table_data[i,2] = err
    end

    return table_data
end

# Aufruf
table_data = test_thomas_vs_builtin()
header = ["N", "Max. Fehler"]
pretty_table(table_data; header=(header,), formatters=ft_printf("%.4e", 2), title="Fehler durch Thomas-Algorithmus")