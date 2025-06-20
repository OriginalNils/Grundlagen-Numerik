using LinearAlgebra
using PrettyTables

# Funktion f(x, y)
f(x, y) = 2π^2 * sin(π * x) * sin(π * y)

# Exakte Lösung
u_exact(x, y) = sin(π * x) * sin(π * y)

function create_D(n)
    T = Tridiagonal(-1*ones(n-1), 4*ones(n), -1*ones(n-1)) |> Matrix
    I_n = Matrix{Float64}(I, n, n)
    N = n^2
    D = zeros(N, N)

    for block_row in 0:n-1
        for block_col in 0:n-1
            # Position im großen Block: Zeilen- und Spaltenindex
            i = block_row + 1
            j = block_col + 1
            block_index = (i - 1) * n + 1 : i * n, (j - 1) * n + 1 : j * n

            if i == j
                D[block_index...] .= T
            elseif abs(i - j) == 1
                D[block_index...] .= -I_n
            end
        end
    end
    
    return D
end

function own_lu(A)
    n = size(A, 1)
    L = Matrix{Float64}(I, n, n)
    U = A

    for i in 1:n-1
        for k in i+1:n
            L[k,i] = U[k,i]/U[i,i]
            for j in i:n
                U[k,j] = U[k,j] - L[k,i]*U[i,j]
            end
        end
    end

    return L, U
end

# Vorwärtssubstitution
function forward_substitution(L, b)
    n = length(b)
    y = zeros(n)
    for i in 2:n
        y[i] = b[i] - sum(L[i, j] * y[j] for j in 1:i-1)
    end
    return y
end

# Rückwärtssubstitution
function backward_substitution(U, y)
    n = length(y)
    x = zeros(n)
    for i in n:-1:1
        if i == n
            x[i] = y[i] / U[i, i]
        else
            x[i] = (y[i] - sum(U[i, j] * x[j] for j in i+1:n)) / U[i, i]
        end
    end
    return x
end

# Numerische Lösung für gegebenes n
function solve_PDE(n)
    h = 1 / (n + 1)
    x = [i * h for i in 1:n]
    y = [j * h for j in 1:n]

    # Rechte Seite b (Vektorisierung von f(x,y))
    b = zeros(n^2)
    for j in 1:n
        for i in 1:n
            idx = (j-1) * n + i
            b[idx] = f(x[i], y[j])
        end
    end

    # Matrix D
    D = create_D(n)

    # LU-Zerlegung + Lösen
    L, U = own_lu(D)
    y_temp = forward_substitution(L, b)
    u_num = backward_substitution(U, y_temp)

    # Exakte Lösung
    u_true = zeros(n^2)
    for j in 1:n
        for i in 1:n
            idx = (j-1) * n + i
            u_true[idx] = u_exact(x[i], y[j])
        end
    end

    # Fehlernorm
    err = norm(u_num - u_true)
    return err
end

ns = [5,10,15,20,25,30,50]

header = ["n", "Fehler"]
table_data = zeros(Float64, length(ns), 2)

# Test für verschiedene n
for (i,n) in enumerate(ns)
    table_data[i, 1] = n
    table_data[i, 2] = solve_PDE(n)
end

pretty_table(table_data; header=header, formatters=ft_printf("%.4e", 2), title="Fehler LU-Zerlegung", compact_printing = false, crop = :none)