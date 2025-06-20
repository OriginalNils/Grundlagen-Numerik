using LinearAlgebra
using PrettyTables

function A_ij(n)
    A = zeros(n,n)
    for i in 1:n
        for j in 1:n
            if i == j
                A[i,j] = max(10^(-14), (0.001)^i)
            else
                A[i,j] = 1+ 1/(i+j)
            end
        end
    end
    return A
end

function rnd_sol(n)
    xstar = zeros(n)
    for i in 1:n
        xstar[i] = i
    end
    return xstar, A_ij(n)*xstar
end

function LU_wo_Pivot(A, b)

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

    y = zeros(n)
    for i in 2:n
        y[i] = b[i] - sum(L[i, j] * y[j] for j in 1:i-1)
    end
    
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


function LU_vollpivot(A, b)
    n = size(A, 1)
    U = copy(A)
    L = Matrix{Float64}(I, n, n)
    P = Matrix{Float64}(I, n, n)
    Q = Matrix{Float64}(I, n, n)

    for k in 1:n-1
        # Suche globales Maximum in U[k:n, k:n]
        subU = abs.(U[k:end, k:end])
        maxval, idx_linear = findmax(vec(subU))
        rows, cols = size(subU)
        i_max = (idx_linear - 1) % rows + 1
        j_max = (idx_linear - 1) ÷ rows + 1

        # Rückverschiebung auf ursprüngliche Matrix
        i_max += k - 1
        j_max += k - 1

        # Zeilen tauschen
        U[[k, i_max], :] = U[[i_max, k], :]
        P[[k, i_max], :] = P[[i_max, k], :]
        if k > 1
            L[[k, i_max], 1:k-1] = L[[i_max, k], 1:k-1]
        end

        # Spalten tauschen
        U[:, [k, j_max]] = U[:, [j_max, k]]
        Q[:, [k, j_max]] = Q[:, [j_max, k]]

        # Gauß-Elimination
        for i in k+1:n
            L[i,k] = U[i,k] / U[k,k]
            U[i, k:n] .-= L[i,k] * U[k, k:n]
        end
    end

    # Vorwärtssubstitution: Ly = Pb
    Pb = P * b
    y = zeros(n)
    for i in 1:n
        y[i] = Pb[i] - sum(L[i,j]*y[j] for j in 1:i-1; init=0.0)
    end

    # Rückwärtssubstitution: Ux̃ = y
    x̃ = zeros(n)
    for i in n:-1:1
        if i == n
            x̃[i] = y[i] / U[i,i]
        else
            x̃[i] = (y[i] - sum(U[i,j]*x̃[j] for j in i+1:n)) / U[i,i]
        end
    end

    # Permutiere x̃ entsprechend Qᵗ
    x = Q' * x̃
    return x
end

Ns = [5,10,100,300,400,500,600,700,800,900,1000,2000]

header = ["N", "Fehler kein Pivot.", "Fehler vollst. Pivot."]
table_data = zeros(Float64, length(Ns), 3)

for (i, N) in enumerate(Ns)
    A = A_ij(N)
    xstar, b = rnd_sol(N)
    table_data[i, 1] = N
    table_data[i, 2] = norm(xstar - LU_wo_Pivot(A, b), Inf)
    table_data[i, 3] = norm(xstar - LU_vollpivot(A, b), Inf)
end

pretty_table(table_data; header=header, formatters=ft_printf("%.4e", 2:3), title="Fehler kein/vollst. Pivot.", compact_printing = false, crop = :none)