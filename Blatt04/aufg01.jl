using LinearAlgebra
using Plots

# Funktion zur Berechnung der natürlichen kubischen Spline-Koeffizienten (σ)
function natural_cubic_spline(x, y)
    n = length(x) - 1
    Δx = diff(x)

    A = zeros(n - 1, n - 1)
    b = zeros(n - 1)

    for i in 1:n-1
        Δx_i = Δx[i]
        

        # Matrix A gemäß Skript
        if i == 1
            A[i, i] = 2 * Δx_i
        else i > 1
            Δx_im1 = Δx[i-1]
            A[i, i-1] = Δx_im1
            A[i, i] = 2 * (Δx_i + Δx_im1)
        end
        if i < n - 1
            A[i, i+1] = Δx_i
        end

        if i == 1 || i == n-1
            b[i] = y[i+1] - y[i]
        else
            b[i] = 3 * (
                (y[i+1] - y[i]) * (Δx[i-1] / Δx[i]) +
                (y[i] - y[i-1]) * (Δx[i] / Δx[i-1])
            )
        end
    end

    σ_inner = A \ b
    return vcat(0.0, σ_inner, 0.0)
end


# Funktion zur Auswertung des Spline an vielen Punkten
function spline_evaluate(x_eval, x, y, sigma)
    n = length(x) - 1
    s_vals = zeros(length(x_eval))

    for i in 1:n
        xi, xi1 = x[i], x[i+1]
        hi = xi1 - xi

        # Indizes für das aktuelle Intervall
        idx = findall(t -> xi ≤ t ≤ xi1, x_eval)

        for j in idx
            t = x_eval[j]
            a = (xi1 - t) / hi
            b = (t - xi) / hi
            s_vals[j] = a*y[i] + b*y[i+1] +
                        ((a^3 - a)*sigma[i] + (b^3 - b)*sigma[i+1]) * hi^2 / 6
        end
    end
    return s_vals
end

# Hauptfunktion für Plot und Vergleich
function run_spline_interpolation(f, label, length)
    x_nodes = range(-1, 1, length=length)
    y_nodes = f.(x_nodes)
    sigma = natural_cubic_spline(collect(x_nodes), y_nodes)

    x_fine = range(-1, 1, length=500)
    spline_vals = spline_evaluate(collect(x_fine), collect(x_nodes), y_nodes, sigma)

    plt = plot(x_fine, f.(x_fine), label="Original: $label",linestyle=:dash, lw=2)
    plot!(x_fine, spline_vals, label="Spline")
    scatter!(x_nodes, y_nodes, label="Stützstellen", legend=:bottomright)
    title!("Spline-Interpolation für $label")
    xlabel!("x")
    ylabel!("y")
    display(plt)
end

# Beispielplots
run_spline_interpolation(x -> sin(2π*x), "sin(2πx)", 25)
run_spline_interpolation(x -> cos(exp(x)), "cos(exp(x))",25)
