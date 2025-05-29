using Plots

# Globales Trapezverfahren (implizit) mit Fixpunktiteration
function trapez_global(f, t0, T, u0, N; max_iter=10, tol=1e-10)
    h = (T - t0) / N
    ts = collect(t0:h:T)
    us = zeros(length(ts))
    us[1] = u0

    for j in 2:lastindex(ts)
        # Initialer Schätzwert für u_j (z.B. vorheriger Wert)
        u_guess = us[j-1]
        for _ in 1:max_iter
            if j > 2
                sum_terms = sum(f(ts[k], us[k]) for k in 2:j-1)
            else
                sum_terms = 0.0
            end
            trapez_sum = h * (0.5 * f(ts[1], us[1]) + sum_terms + 0.5 * f(ts[j], u_guess))
            u_new = u0 + trapez_sum
            if abs(u_new - u_guess) < tol
                break
            end
            u_guess = u_new
        end
        us[j] = u_guess
    end
    return ts, us
end

# Analytische Lösung
u_exact(t) = 1 / (1 + exp(-t))
# Funktion f(t, u)
f(t, u) = u * (1 - u)

# Parameter
t0 = 0.0
T = 10.0
u0 = 0.5
Ns = [5,10, 15, 30, 60]

# Plot der Lösungen
plt1 = plot(title="Lösungsvergleich", xlabel="t", ylabel="u(t)")
for N in Ns
    ts, us = trapez_global(f, t0, T, u0, N)
    plot!(plt1, ts, us, label="Numerisch N=$N", lw=2)
end
ts_dense = range(t0, T, length=1000)
plot!(plt1, ts_dense, u_exact.(ts_dense), label="Analytisch", lw=3, linestyle=:dash)

display(plt1)