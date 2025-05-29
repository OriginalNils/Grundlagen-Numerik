using Plots

g = 9.81

function K_simpson(k; N=1000)
    a, b = 0.0, π/2
    h = (b - a) / N
    s = 1/(sqrt(1-k^2*sin(a + 0 * h)^2)) + 1/(sqrt(1-k^2*sin(a + N * h)^2))

    for i in 1:N-1
        if i % 2 == 0
            s += 2*(1/(sqrt(1-k^2*sin(a + i * h)^2)))
        else
            s += 4*(1/(sqrt(1-k^2*sin(a + i * h)^2)))
        end
    end

    return (h / 3) * s
end

function K_trapez(k; N=1000)
    a, b = 0.0, π/2
    h = (b - a) / N
    s = 1/(2*(sqrt(1-k^2*sin(a + 0 * h)^2))) + 1/(2*(sqrt(1-k^2*sin(a + N * h)^2)))

    for i in 1:N-1
        s += 1/(sqrt(1-k^2*sin(a + i * h)^2))
    end

    return h * s
end

function AGM(a,b, max_iter)
    for _ in 1:max_iter
        a_next = (a+b)/2
        b_next = sqrt(a*b)
        a, b = a_next, b_next
    end
    return a
end

function K_agm(k, max_iter)
    return pi / (2 * AGM(1.0, sqrt(1-k^2), max_iter))
end

function T_agm(p0_vals, max_iter; g=9.81)
    return [4 * sqrt(1 / g) * K_agm(sin(p0 / 2), max_iter) for p0 in p0_vals]
end

function T_trapez(p0_vals; g=9.81)
    return [4 * sqrt(1 / g) * K_trapez(sin(p0 / 2)) for p0 in p0_vals]
end

function T_simpson(p0_vals; g=9.81)
    return [4 * sqrt(1 / g) * K_simpson(sin(p0 / 2)) for p0 in p0_vals]
end

function error_period_simps(iters, p0_vals)
    lst_simps_vals = T_simpson(p0_vals)
    lst_return = []
    for iter in iters
        temp_vals = T_agm(p0_vals, iter)
        diff_vals = [abs(lst_simps_vals[i]-temp_vals[i]) for i in 1:length(p0_vals)]
        push!(lst_return, diff_vals)
    end
    return lst_return
end

function error_period_trapez(iters, p0_vals)
    lst_simps_vals = T_trapez(p0_vals)
    lst_return = []
    for iter in iters
        temp_vals = T_agm(p0_vals, iter)
        diff_vals = [abs(lst_simps_vals[i]-temp_vals[i]) for i in 1:length(p0_vals)]
        push!(lst_return, diff_vals)
    end
    return lst_return
end

p0_vals = range(0.0, stop=2π, length=20)
p0_vals_degr = [rad * 180/π for rad in p0_vals]
iters = [5,6,10,12]
T_linear = (2π)/sqrt(g)
header = ["Itterationen", "Fehler zu Trapezregel", "Fehler zu Simpson"]
diffs_simps = error_period_simps(iters, p0_vals)
diffs_trapez = error_period_trapez(iters, p0_vals)

# Plot
p0 = plot(p0_vals_degr, T_trapez(p0_vals; g=9.81), label="Nichtlineare Periode [s]", lw=2, xticks = 0:30:360, xlabel="Anfangsauslenkung φ₀ [°]", ylabel="Periode T", title="Periodendauer eines Pendels mit Trapezregel")
hline!(p0, [T_linear], label="Lineare Periode", linestyle=:dash, color=:red)
p1 = plot(p0_vals_degr, T_simpson(p0_vals; g=9.81), label="Nichtlineare Periode [s]", lw=2,xticks = 0:30:360, xlabel="Anfangsauslenkung φ₀ [°]", ylabel="Periode T", title="Periodendauer eines Pendels mit Simpson")
hline!(p1, [T_linear], label="Lineare Periode", linestyle=:dash, color=:red)


p2 = plot(p0_vals_degr, diffs_simps[1], label="Fehler Iteration: $(iters[1])", lw=2,xticks = 0:30:360, xlabel="Anfangsauslenkung φ₀ [°]", ylabel="Fehler |T_agm - T_Q|", title="Fehler zw. Periodendauer AGM und Simpson")
p3 = plot(p0_vals_degr, diffs_trapez[1], label="Fehler Iteration: $(iters[1])", lw=2,xticks = 0:30:360, xlabel="Anfangsauslenkung φ₀ [°]", ylabel="Fehler |T_agm - T_Q|", title="Fehler zw. Periodendauer AGM und Trapez")

for i in eachindex(iters)
    if i == 1
        continue
    end
    plot!(p2, p0_vals_degr, diffs_simps[i], label="Fehler Iteration: $(iters[i])", lw=2)
    plot!(p3, p0_vals_degr, diffs_trapez[i], label="Fehler Iteration: $(iters[i])", lw=2)
end

display(p0)
display(p1)
display(p2)
display(p3)