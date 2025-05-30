using Plots

function legendre_pols(n,x)
    if n == 0
        return 1.0
    elseif n == 1
        return x
    else
        Pnm2 = 1.0  # P_0(x)
        Pnm1 = x    # P_1(x)
        Pn = 0.0
        for k in 1:n-1
            Pn = ((2k + 1) * x * Pnm1 - k * Pnm2) / (k + 1)
            Pnm2, Pnm1 = Pnm1, Pn
        end
        return Pn
    end
end

function legendre_p_derivative(n, x)
    if n == 0
        return 0.0
    elseif n == 1
        return 1.0
    else
        Pn = legendre_pols(n, x)
        Pnm1 = legendre_pols(n-1, x)
        return n / (1 - x^2) * (Pnm1 - x * Pn)
    end
end

function legendre_roots(n; tol=2*eps(Float64), maxiter=20)
    roots = zeros(n)
    m = div(n + 1, 2)  # Anzahl der Nullstellen, die wir iterieren müssen (Symmetrie)
    
    for j in 0:m-1
        # Chebyshev-Startwert
        x = -cos( (2j + 1) * pi / (2n + 2) )
        
        for i in 1:maxiter
            Px = legendre_pols(n, x)
            dPx = legendre_p_derivative(n, x)
            dx = - Px / dPx
            x += dx
            if abs(dx) < tol
                break
            end
        end
        
        # Nullstellen paarweise speichern
        roots[j+1] = x
        roots[n-j] = -x  # wegen P_n(-x) = (-1)^n P_n(x)
    end
    
    # Wenn n ungerade ist, mittlere Nullstelle liegt bei 0
    if isodd(n)
        roots[m] = 0.0
    end
    
    return sort(roots)
end

# Plotten der Polynome mit Nullstellen
xvals = -1:0.001:1

plot()
for n in 1:6
    yvals = [legendre_pols(n, x) for x in xvals]
    r = legendre_roots(n)
    
    # Polynom zeichnen
    plot!(xvals, yvals, label="P_$n")
    # Nullstellen als Punkte
    scatter!(r, zeros(length(r)), label="", markersize=4, color=:black)
end

xlabel!("x")
ylabel!("P_n(x)")
title!("Legendre-Polynome bis Ordnung 6 mit Nullstellen")
plot!()