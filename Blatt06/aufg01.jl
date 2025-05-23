using PrettyTables

function simpson_quadr(f,N,a,b)
    ints = collect(range(a, b, length=N))
    result = 0.0

    for i in 1:length(ints)-1
        a_int = ints[i]
        b_int = ints[i+1]
        result += ((b_int-a_int)/8)*(f(a_int) + 3*f((2*a_int+b_int)/3) + 3*f((a_int+2*b_int)/3) + f(b_int))
    end

    return result
end

function bool_quadr(f,N,a,b)
    ints = collect(range(a, b, length=N))
    result = 0.0

    for i in 1:length(ints)-1
        a_int = ints[i]
        b_int = ints[i+1]
        result += ((b_int-a_int)/90)*(7*f(a_int) + 32*f((3*a_int+b_int)/4) + 12*f((a_int+b_int)/2) + 32*f((a_int+3*b_int)/4) + 7*f(b_int))
    end

    return result
end

f(x) = exp(x)
g(x) = abs(x)
h(x) = cos(x)

exact_funct = [exp(1)-exp(-1) 1 2*sin(1); f g h]

Ns = [3,6,12,40,80,200]

header = ["N", "Analytisch", "Simpson Fehler", "Bool Fehler"]

for j in 1:3
    table_data = zeros(Float64, length(Ns), 4)
    for (i, N) in enumerate(Ns)
        table_data[i, 1] = N
        table_data[i, 2] = exact_funct[1, j]
        table_data[i, 3] = abs(exact_funct[1, j] - simpson_quadr(exact_funct[2, j], N, -1, 1))
        table_data[i, 4] = abs(exact_funct[1, j] - bool_quadr(exact_funct[2, j], N, -1, 1))
    end
    pretty_table(table_data; header=header, title="Fehler von $(exact_funct[2,j])")
end