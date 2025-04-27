using Printf
using PrettyTables
using LinearAlgebra
using Statistics
using BenchmarkTools

function aufg01()

    # Funktion f(x) = sin(exp(x))
    f(x) = sin(exp(x))

    # Funktion zur Erstellung der Vandermonde-Matrix
    function vandermonde(x::Vector{T}) where T
        n = length(x)
        V = [x[i]^(j-1) for i in 1:n, j in 1:n]
        return V
    end

    # Funktion zur Berechnung der Determinante der Vandermonde-Matrix
    function vandermonde_determinant(x::Vector{T}) where T
        n = length(x)
        det = one(T)
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

    x = [1, 4, 19, 22]
    V = vandermonde(x)
    println(V)
    println("Determinante: ", vandermonde_determinant(x))
    test_determinanten_pretty()
    test_interpolation_zeiten(collect(2:10), 10)
    

end