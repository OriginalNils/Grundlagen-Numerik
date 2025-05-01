using Printf
using PrettyTables
using LinearAlgebra
using Statistics
using Polynomials
using BenchmarkTools

function aufg01()

    # Funktion f(x) = sin(exp(x))
    f(x) = sin(exp(x))

    # Funktion zur Erstellung der Vandermonde-Matrix
    function vandermonde(x::Vector{Float64})
        n = length(x)
        V = [x[i]^(j-1) for i in 1:n, j in 1:n]
        return V
    end    

    # Funktion zur Berechnung der Determinante der Vandermonde-Matrix
    function vandermonde_determinant(x::Vector{Float64})
        n = length(x)
        det = one(Float64)
        for i in 1:n-1
            for j in i+1:n
                det *= (x[j] - x[i])
            end
        end
        return det
    end

    # Funktion zur Diskretisierung des Intervalls [0,10] in N äquidistante Punkte
    function diskretisiere_intervall(N::Int)
        return range(0, stop=10, length=N)
    end

    # Funktion für die Tests und PrettyTables-Ausgabe
    function test_determinanten_pretty()
        N_values = 2:10
        num_rows = length(N_values)
        table_data = zeros(Float64, num_rows, 4)  # Matrix: Zeilen = verschiedene N
    
        for (i, N) in enumerate(N_values)
            x = collect(diskretisiere_intervall(N))
            V = vandermonde(x)
            
            det_ana = vandermonde_determinant(x)
            det_num = det(V)
            fehler = abs(det_ana - det_num)
            
            table_data[i, 1] = N
            table_data[i, 2] = det_ana
            table_data[i, 3] = det_num
            table_data[i, 4] = fehler
        end
    
        header = ["N", "det_ana", "det_num", "|det_ana - det_num|"]
        pretty_table(table_data; header=(header,), formatters=ft_printf("%.4e", 2:4), title="Vergleich der Determinanten")
    end

    function test_interpolation_zeiten(N_values::Vector{Int}, num_repeats::Int)
        num_rows = length(N_values)
        table_data = zeros(Float64, num_rows, 3)  # Spalten: N, avg_time, cond
    
        for (i, N) in enumerate(N_values)
            x = collect(diskretisiere_intervall(N))
            V = vandermonde(x)
            fx = f.(x)
    
            # Miss Zeiten für num_repeats Wiederholungen
            zeiten = zeros(Float64, num_repeats)
            for j in 1:num_repeats
                t = @elapsed begin
                    a = V \ fx
                end
                zeiten[j] = t
            end
    
            avg_time = mean(zeiten)
            kappa = cond(V, 1)  # Konditionszahl in 1-Norm
    
            table_data[i, 1] = N
            table_data[i, 2] = avg_time
            table_data[i, 3] = kappa
        end
        header = ["N", "avg_time (s)", "κ (cond_1)"]
        pretty_table(table_data; header=header, formatters=ft_printf("%.4e", 2:3), title="Interpolation von f(x) = sin(exp(x))")
    end

    test_determinanten_pretty()
    test_interpolation_zeiten(collect(2:10), 10)
    
end

function aufg02()
    # Definiere die Funktionen f, g, h
    f(x) = abs(x)
    g(x) = abs(sin(5 * x))^3
    h(x) = exp(-x^2)

    # Lagrange-Interpolationspolynom
    function bary_gewichte(xs)
        N = length(xs) - 1  # Anzahl der Stützpunkte
        ws = zeros(Float64, N+1)  # Array für die Gewichte

        for i in 0:N
            ws[i+1] = 1.0
            for j in 0:N
                if j != i
                    ws[i+1] *= (xs[i+1] - xs[j+1])  # Produkt für jedes i
                end
            end
            ws[i+1] = 1.0 / ws[i+1]  # Inverses Produkt für das Gewicht
        end
        return ws
    end

    function bary_polynome(xs, ys)
        ws = bary_gewichte(xs)  # Baryzentrische Gewichte berechnen
        N = length(xs) - 1  # Anzahl der Stützpunkte

        # Funktion p(x) zurückgeben
        function p(x)
            # Falls x genau ein Stützpunkt ist, direkt Wert liefern
            for (i, xi) in enumerate(xs)
                if isapprox(x, xi; atol=1e-14)
                    return ys[i]
                end
            end

            # Ansonsten die baryzentrische Formel verwenden
            numerator = 0.0
            denominator = 0.0
            for j in 0:N
                diff = x - xs[j+1]
                temp = ws[j+1] / diff
                numerator += temp * ys[j+1]
                denominator += temp
            end
            return numerator / denominator
        end

        return p
    end

    # Berechnung der Supremumsnorm
    function supremum_norm(f, p, xs)
        errors = abs.(f.(xs) .- p.(xs))
        return maximum(errors)
    end

    # Durchführen des Konvergenztests für die Funktion
    function konvergenztest(f, xs, xeval, max_order=10)
        norms = Float64[]

        for N in 1:max_order
            # Wähle N Stützpunkte
            stützpunkte = LinRange(xs[1], xs[end], N + 1)  # Erstelle N Stützpunkte
            ys = f.(stützpunkte)
            
            # Interpolation durchführen
            p = bary_polynome(stützpunkte, ys)
            
            # Supremumsnorm berechnen
            norm = supremum_norm(f, p, xeval)
            push!(norms, norm)
        end

        return norms
    end

    # Test für die Funktionen f, g, h durchführen
    N = 50
    M = 100
    xs = LinRange(-1, 1, N + 2)
    xeval = LinRange(-1, 1, M + 2)
    max_order = 10

    # Konvergenztest für jede Funktion durchführen
    norm_f = konvergenztest(f, xs, xeval, max_order)
    norm_g = konvergenztest(g, xs, xeval,max_order)
    norm_h = konvergenztest(h, xs, xeval,max_order)

    table_data = zeros(Float64, max_order, 4)

    for i in 1:max_order
        table_data[i, 1] = i
        table_data[i, 2] = norm_f[i]
        table_data[i, 3] = norm_g[i]
        table_data[i, 4] = norm_h[i]
    end

    header = ["N", "f Supremumsnorm", "g Supremumsnorm", "h Supremumsnorm"]
    pretty_table(table_data; header=header, title="Maximaler Fehler der Funktionen")

end

function aufg03()
    function horner(a::Vector{Float64}, x0::Float64)
        # Start mit dem höchsten Koeffizienten
        b = a[end]
        
        # Iteriere rückwärts durch die Koeffizienten
        for i in length(a)-1:-1:1
            b = a[i] + b * x0
        end
        
        return b
    end
    
    
    a = [1.0, 0.0, 0.0, 1234/1775, 0.0, 0.0, 0.0, 0.0, 23/1775, 0.0, 76/1775]

    # Funktion zur Erstellung einer Wertetabelle
    function create_value_table(func, coefficients, x_values)
        table = zeros(Float64, length(x_values), 2)
        for i in eachindex(x_values)  # Iterieren mit eachindex
            x = x_values[i]
            p_x = func(coefficients, x)
            table[i, 1] = x    # x-Wert in die erste Spalte
            table[i, 2] = p_x  # Funktionswert p(x) in die zweite Spalte
        end
        return table
    end

    # Werte von x, für die das Polynom ausgewertet wird
    x_values = -2:0.5:2  # z.B. Werte von -2 bis 2 in Schritten von 0.5

    # Wertetabelle erstellen
    table_data = create_value_table(horner, a, x_values)
    header = ["x", "p(x)"]
    pretty_table(table_data; header=header, title="Auswertung der Funktion p(x)")
end