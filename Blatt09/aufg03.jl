using LinearAlgebra
using Plots

# (iii) Rosenbrock-Funktion und ihre Ableitungen
function f(x)
    return (1 - x[1])^2 + 100 * (x[2] - x[1]^2)^2
end

function grad_f(x)
    df_dx = -2 * (1 - x[1]) - 400 * x[1] * (x[2] - x[1]^2)
    df_dy = 200 * (x[2] - x[1]^2)
    return [df_dx, df_dy]
end

function hess_f(x)
    dxx = 2 - 400 * x[2] + 1200 * x[1]^2
    dxy = -400 * x[1]
    dyy = 200
    return [dxx dxy; dxy dyy]
end

# Gradientverfahren mit fester Schrittweite α
function gradient_method(x0, a, tol, max_iter=10^4)
    x = copy(x0)
    history = [copy(x)]
    converged = false
    for _ in 1:max_iter
        g = grad_f(x)
        x_new = x .- a .* g
        push!(history, copy(x_new))
        if norm(x_new - x) < tol
            converged = true
            x = x_new
            break
        end
        x = x_new
    end
    return converged, x, history
end

# Newton-Verfahren
function newton_method(x0, tol, max_iter=10^4, br_stop = false)
    x = copy(x0)
    history = [copy(x)]
    converged = false
    for _ in 1:max_iter
        g = grad_f(x)
        H = hess_f(x)
        Δx = H \ g
        x_new = x .- Δx
        push!(history, copy(x_new))
        if norm(x_new - x) < tol
            converged = true
            x = x_new
            if br_stop == false: break end
        end
        x = x_new
    end
    return converged, x, history
end


# Konvergenztest
ε = eps(Float64)
tol = 4 * ε
x0 = [1.2, 1.2]

println("Teste α = 10^(-i) für i = 1 bis 20 mit Gradient:")
for i in 1:20
    a = 10.0^-i
    converged, x_res, hist = gradient_method(x0, a, tol)
    println("α = 10^(-$i): konvergiert = $converged, diff = ", norm(x_res - hist[end-1]))
end

println("Teste α = 10^(-i) für i = 1 bis 20 mit Newton:")
for i in 1:20
    a = 10.0^-i
    converged, x_res, hist = newton_method(x0, a)
    println("α = 10^(-$i): konvergiert = $converged, diff = ", norm(x_res - hist[end-1]))
end

# (v) Konvergenzrate plotten
x_star = [1.0, 1.0]
a = 0.001

_, _, grad_hist = gradient_method(x0, 0.001, tol, 15)
_, _, newt_hist = newton_method(x0, tol, 15, true)

function convergence_rates(history, x_star)
    rates = []
    eps = 1e-16
    for k in 1:(length(history)-1)
        num = log(norm(history[k+1] - x_star) + eps)
        den = log(norm(history[k] - x_star) + eps)
        push!(rates, num / den)
    end
    return rates
end


grad_rates = convergence_rates(grad_hist, x_star)
newt_rates = convergence_rates(newt_hist, x_star)


plot(grad_rates, label="Gradientenverfahren", xlabel="Iteration", ylabel="Konvergenzrate p")
plot!(newt_rates, label="Newton-Verfahren", title="Konvergenzrate p über Iterationen")
