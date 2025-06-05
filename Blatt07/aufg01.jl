using LinearAlgebra
using PrettyTables

function gauß_matrix(n)
    u = zeros(n)
    l = zeros(n)

    for i in 1:n
        u[i] = sqrt(i/2)
        l[i] = sqrt(i/2)
    end
    return Tridiagonal(l, zeros(n+1), u)
end

function knoten_gewichte(matrix)
    n = size(matrix,1)
    eig = eigen(matrix)
    ew, ev = eig.values, eig.vectors
    weights = [sqrt(pi)*(ev[1,k]^2) for k in 1:n]
    return ew, weights
end

xk, wk = knoten_gewichte(gauß_matrix(3))
header = ["Grad", "Exakt", "Approx", "Fehler"]
table_data = zeros(Float64, 5, 4)

for (i,k) in enumerate(0:2:8)
    approx = sum(wk .* xk.^k)
    exact = sqrt(pi)/(2^(k/2))
    if k == 4
        exact = (3*sqrt(pi))/(2^(k/2))
    elseif k==6
        exact = (15*sqrt(pi))/(2^(k/2))
    elseif k == 8
        exact = (105*sqrt(pi))/(2^(k/2))
    end
    table_data[i, 1] = k
    table_data[i, 2] = exact
    table_data[i, 3] = approx
    table_data[i, 4] = abs(exact - approx)
end

pretty_table(table_data;
    header=header,
    formatters=ft_printf("%.4e", 2:4),
    title="Fehler durch Gauß Quadratur Grad 4",
    compact_printing = false,
    crop = :none
)