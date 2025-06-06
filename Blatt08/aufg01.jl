using LinearAlgebra
using PrettyTables

f(x) = x^3 - 2*x + 2
fabl(x) = 3*x^2 - 2
a0 = -2.0
b0 = -1.0
tol = 4.0*eps()

function bisektion(f,a,b,tol)
    aiter = a
    biter = b
    c = (a+b)/2
    while abs(f(c)) > tol
        if f(c) > 0
            biter = c
        else
            aiter = c
        end
        c = (aiter+biter)/2
    end
    return c
end

function newton(x0, f,fabl, iter)
    x = x0
    if iter == 0
        return x
    end
    for _ in 1:iter
        x = x - f(x)/fabl(x)
    end
    return x
end

x0_vals = [2,0,1,0.0835,1.51]
header1 = ["Iterationen", "Bisektion", "Newton x0=$(x0_vals[1])", "Fehler x0=$(x0_vals[1])", "Newton x0=$(x0_vals[2])", "Fehler x0=$(x0_vals[2])", "Newton x0=$(x0_vals[3])", "Fehler x0=$(x0_vals[3])"]
header2 = ["Iterationen", "Bisektion", "Newton x0=$(x0_vals[4])", "Fehler x0=$(x0_vals[4])", "Newton x0=$(x0_vals[5])", "Fehler x0=$(x0_vals[5])"]
table_data1 = zeros(Float64, 21, 8)
table_data2 = zeros(Float64, 21, 6)

for i in 0:20
    table_data1[i+1, 1] = i
    table_data1[i+1, 2] = bisektion(f, a0, b0, tol)
    table_data1[i+1, 3] = newton(x0_vals[1],f,fabl,i)
    table_data1[i+1, 4] = abs(table_data[i+1, 2] - table_data[i+1, 3])
    table_data1[i+1, 5] = newton(x0_vals[2],f,fabl,i)
    table_data1[i+1, 6] = abs(table_data[i+1, 2] - table_data[i+1, 5])
    table_data1[i+1, 7] = newton(x0_vals[3],f,fabl,i)
    table_data1[i+1, 8] = abs(table_data[i+1, 2] - table_data[i+1, 7])
    table_data2[i+1, 1] = i
    table_data2[i+1, 2] = bisektion(f, a0, b0, tol)
    table_data2[i+1, 3] = newton(x0_vals[4],f,fabl,i)
    table_data2[i+1, 4] = abs(table_data[i+1, 2] - table_data[i+1, 3])
    table_data2[i+1, 5] = newton(x0_vals[5],f,fabl,i)
    table_data2[i+1, 6] = abs(table_data[i+1, 2] - table_data[i+1, 5])
end

pretty_table(table_data1; header=header1, formatters=ft_printf("%.4e", 2:8), title="Fehler je Iteration durch Newton", compact_printing = false, crop = :none)

pretty_table(table_data2; header=header2, formatters=ft_printf("%.4e", 2:12), title="Fehler je Iteration durch Newton", compact_printing = false, crop = :none)