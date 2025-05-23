using Plots
using PrettyTables

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

function T_agm(p0, max_iter; g=9.81)
    return 4 * sqrt(1 / g) * K_agm(sin(p0 / 2), max_iter)
end

function T_trapez(p0_vals; g=9.81)
    return [4 * sqrt(1 / g) * K_trapez(sin(p0 / 2)) for p0 in p0_vals]
end

function T_simpson(p0_vals; g=9.81)
    return [4 * sqrt(1 / g) * K_simpson(sin(p0 / 2)) for p0 in p0_vals]
end

p0_vals = range(0.01, stop=π-0.01, length=8)
iters = [1,2,6,14,20]
T_linear = 2π * sqrt(1 / g)
header = ["Itterationen", "Fehler zu Trapezregel", "Fehler zu Simpson"]

# Plot
p0 = plot(p0_vals, T_trapez(p0_vals; g=9.81), label="Nichtlineare Periode", lw=2, xlabel="Anfangsauslenkung φ₀ [rad]", ylabel="Periode T [s]", title="Periodendauer eines Pendels mit Trapezregel")
hline!(p0, [T_linear], label="Lineare Periode", linestyle=:dash, color=:red)
p1 = plot(p0_vals, T_simpson(p0_vals; g=9.81), label="Nichtlineare Periode", lw=2, xlabel="Anfangsauslenkung φ₀ [rad]", ylabel="Periode T [s]", title="Periodendauer eines Pendels mit Simpson")
hline!(p1, [T_linear], label="Lineare Periode", linestyle=:dash, color=:red)

display(p0)
display(p1)

for (j, p0) in enumerate(p0_vals)
    table_data = zeros(Float64, length(iters), 3)
    trapez = T_trapez(p0_vals)
    simpson = T_simpson(p0_vals)
    for (i, iter) in enumerate(iters)
        table_data[i, 1] = iter
        table_data[i, 2] = abs(trapez[j]-T_agm(p0, iter))
        table_data[i, 3] = abs(simpson[j]-T_agm(p0, iter))
    end
    pretty_table(table_data; header=header, title="Fehler von phi_0=$(p0)")
end