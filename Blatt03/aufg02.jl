using Plots

N=60
M=15

# Runge-Funktion
runge(x) = 1 / (1 + 25x^2)

# Gitter wie in aufg01
function diskretisiere(N, M)
    N % M == 0 || error("N muss ein Vielfaches von M sein.")
    return collect(range(-1, 1, length=N+1))
end

# Ursprüngliches Gitter und Funktionswerte
x = diskretisiere(N, M)
f = runge.(x)

# Lineare Spline-Plot
plt = plot(x, f, label="Lineare Spline-Approximation", lw=2, color=:red, marker=:circle)
plot!(runge, -1, 1, label="Runge-Funktion", lw=2, color=:blue, linestyle=:dash)

# Intervallmittelpunkte berechnen
x_mid = [(x[i] + x[i+1])/2 for i in eachindex(x[1:end-1])]

# Spline-Auswertung an den Mittelwerten
f_spline_mid = Float64[]
for i in eachindex(x[1:end-1])
    xi, xi1 = x[i], x[i+1]
    fi, fi1 = f[i], f[i+1]
    t = (x_mid[i] - xi) / (xi1 - xi)
    push!(f_spline_mid, (1 - t)*fi + t*fi1)
end

# Exakte Werte und Fehler
f_exact_mid = runge.(x_mid)
fehler = abs.(f_spline_mid .- f_exact_mid)

# Fehlerplot
plt_error = plot(x_mid, fehler, label="|Spline - Runge|", lw=2, color=:green,
    title="Absoluter Fehler an Intervallmittelpunkten", xlabel="x", ylabel="Fehler")

display(plt)
display(plt_error)