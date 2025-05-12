using Plots

# Bisektionsmethode
function bisection(f, a, b, tol=1e-10, max_iter=1000)
    if f(a) * f(b) > 0
        error("Funktion hat keine Nullstelle im Intervall [a, b]")
    end
    
    for i in 1:max_iter
        c = (a + b) / 2
        fc = f(c)
        
        if abs(fc) < tol
            return c  # Nullstelle gefunden
        elseif f(a) * fc < 0
            b = c  # Nullstelle liegt im linken Intervall
        else
            a = c  # Nullstelle liegt im rechten Intervall
        end
    end
    error("Maximale Iterationen erreicht")
end

# Legendrepolynom p_n(x) rekursiv
function legendre_polynomial(n, x)
    if n == 0
        return 1.0
    elseif n == 1
        return x
    else
        p0 = 1.0
        p1 = x
        for i in 2:n
            p2 = ((2i - 1) * x * p1 - (i - 1) * p0) / i
            p0 = p1
            p1 = p2
        end
        return p1
    end
end

# Berechnung der Nullstellen des n-ten Legendrepolynoms
function find_legendre_zeros(n, tol=1e-10)
    zeros = Float64[]
    # Die Nullstellen von P_n liegen im Intervall [-1, 1]
    # Wir unterteilen das Intervall [-1, 1] in n Teile und suchen Nullstellen
    for i in 1:n
        a = -1 + (i - 1) * 2 / n
        b = -1 + i * 2 / n
        f(x) = legendre_polynomial(n, x)
        zero = bisection(f, a, b, tol)
        push!(zeros, zero)
    end
    return sort(zeros)  # Nullstellen sind in [-1, 1] und werden sortiert
end

# Bestimme die Nullstellen der Legendrepolynome p1, p2, p3
zeros_p1 = find_legendre_zeros(1)
zeros_p2 = find_legendre_zeros(2)
zeros_p3 = find_legendre_zeros(3)

# Plotten der Legendrepolynome
x_vals = LinRange(-1, 1, 400)
p1_vals = [legendre_polynomial(1, x) for x in x_vals]
p2_vals = [legendre_polynomial(2, x) for x in x_vals]
p3_vals = [legendre_polynomial(3, x) for x in x_vals]

# Plot der Polynomkurven
plot(x_vals, p1_vals, label="p1(x)", xlabel="x", ylabel="p_n(x)")
plot!(x_vals, p2_vals, label="p2(x)")
plot!(x_vals, p3_vals, label="p3(x)")

# Nullstellen hinzufügen
scatter!(zeros_p1, [legendre_polynomial(1, z) for z in zeros_p1], label="Nullstellen p1", color=:red)
scatter!(zeros_p2, [legendre_polynomial(2, z) for z in zeros_p2], label="Nullstellen p2", color=:blue)
scatter!(zeros_p3, [legendre_polynomial(3, z) for z in zeros_p3], label="Nullstellen p3", color=:green)
