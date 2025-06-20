using PrettyTables
using Random
using BenchmarkTools
using LinearAlgebra

function foward_subst_row(L, b)
    n = length(b)
    x = zeros(length(b))
    for i in 1:n
        if i == 1
            x[i] = b[i]/L[i,i]
        else
            x[i] = (b[i]-sum(L[i,j]*x[j] for j in 1:i-1))/L[i,i]
        end
    end
    return x
end

function foward_subst_column(L,b)
    n = length(b)
    x = copy(b) 

    for j in 1:n
        x[j] /= L[j,j]
        for i in j+1:n
            x[i] -= L[i,j] * x[j]
        end
    end

    return x
end

function matrix_L(n)
    L = zeros(n,n)
    for i in 1:n
        for j in 1:n
            if i == j
                L[i,j] = 1
            elseif i > j
                L[i,j] = rand([-2,1,0,1,2])
            end
        end
    end
    return L
end

function rnd_sol(n)
    xstar = zeros(n)
    for i in 1:n
        xstar[i] = rand([0,1,2,3,4,5,6,7,8,9])
    end
    return xstar
end

function test_forward(n)
    L = matrix_L(n)
    x_star = rnd_sol(n)
    b = L * x_star
    
    # Erst einmal ausführen und Ergebnis speichern
    x1 = foward_subst_row(L, b)
    x2 = foward_subst_column(L, b)
    
    # Dann Zeit messen für die Funktion (nur den Funktionsaufruf) mit $ für Variablen
    t1 = @belapsed foward_subst_row($L, $b)
    t2 = @belapsed foward_subst_column($L, $b)
    
    # Fehler norm ∞
    err1 = norm(x_star - x1, Inf)
    err2 = norm(x_star - x2, Inf)
    
    return (t_zeilen=t1, t_spalten=t2, err_zeilen=err1, err_spalten=err2)
end

Ns = [10,100,1000,2000,3000,4000,5000,10000,20000]

header = ["N", "Fehler Zeilen", "Zeit Zeilen", "Fehler Spalten", "Zeit Spalten"]
table_data = zeros(Float64, length(Ns), 5)

for (i, N) in enumerate(Ns)
    t_zeilen, t_spalten, err_zeilen, err_spalten = test_forward(N)
    table_data[i, 1] = N
    table_data[i, 2] = err_zeilen
    table_data[i, 3] = t_zeilen
    table_data[i, 4] = err_spalten
    table_data[i, 5] = t_spalten
end

pretty_table(table_data; header=header, formatters=ft_printf("%.4e", 2:5), title="Fehler/Zeit Forward Subst.", compact_printing = false, crop = :none)