using DelimitedFiles
using LinearAlgebra

# 1. Datei einlesen
data, header = readdlm("Blatt05/data_cubic_clamped.txt", '\t', header=true)
t = data[:, 1]
x = data[:, 2]
y = data[:, 3]

# 2. Funktion zum Lösen der Spline-Gleichungen mit clamped Randbedingung
function cubic_clamped_spline(t, v)
    n = length(t)
    h = diff(t)

    A = zeros(n, n)
    rhs = zeros(n)

    # Erste Gleichung: Clamped am linken Rand
    A[1,1] = 2h[1]
    A[1,2] = h[1]
    rhs[1] = 6 * ((v[2] - v[1]) / h[1] - 0)  # s'(t₁) = 0

    # Innenknoten
    for i in 2:n-1
        A[i,i-1] = h[i-1]
        A[i,i]   = 2 * (h[i-1] + h[i])
        A[i,i+1] = h[i]
        rhs[i] = 6 * ((v[i+1] - v[i]) / h[i] - (v[i] - v[i-1]) / h[i-1])
    end

    # Letzte Gleichung: Clamped am rechten Rand
    A[n,n-1] = h[n-1]
    A[n,n]   = 2h[n-1]
    rhs[n] = 6 * (0 - (v[n] - v[n-1]) / h[n-1])  # s'(tₙ) = 0

    M = A \ rhs
    return M
end

function evaluate_cubic_spline(t, v, M, t_eval)
    n = length(t)
    v_eval = similar(t_eval)
    h = diff(t)

    for (j, te) in pairs(t_eval)
        i = findlast(k -> t[k] ≤ te, 1:n-1)
        i = clamp(i === nothing ? 1 : i, 1, n-1)

        hi = t[i+1] - t[i]
        a = (t[i+1] - te) / hi
        b = (te - t[i]) / hi

        s = a * v[i] + b * v[i+1] +
            ((a^3 - a) * M[i] + (b^3 - b) * M[i+1]) * hi^2 / 6
        v_eval[j] = s
    end

    return v_eval
end

# Eval-Punkte
t_eval = range(t[1], t[end], length=100)

# Spline-Lösung
Mx = cubic_clamped_spline(t, x)
My = cubic_clamped_spline(t, y)

# Auswertung
x_eval = evaluate_cubic_spline(t, x, Mx, t_eval)
y_eval = evaluate_cubic_spline(t, y, My, t_eval)

open("Blatt05/data_cubic_clamped_sol.txt", "w") do io
    write(io, "# t x y\n")
    writedlm(io, result, '\t')
end
