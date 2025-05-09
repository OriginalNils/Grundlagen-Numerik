using PrettyTables

function diskretisiere(a,b, N)
    return collect(range(a, b, length=N+1))
end

function vandermonde_matrix(x) #bekommt Stützpunkte
    n = length(x)
    V = [x[i]^j for i in 1:n, j in 0:n-1]
    return V
end

function finde_koeffizienten(x, y)
    V = vandermonde_matrix(x)
    return V \ y  # Löse V * a = y
end

function integriere_polynom(a, b, koeffs)
    s = 0.0
    for (i, ai) in enumerate(koeffs)
        grad = i - 1  # weil a₀ zu x⁰ gehört
        s += ai * (b^(grad + 1) - a^(grad + 1)) / (grad + 1)
    end
    return s
end

f3(x) = (1 - x)^3 * (1 + x)
g3(x) = sin(π * x)
h3(x) = abs(x)

# Test für verschiedene Werte von N
Ns = [5, 10, 20, 50, 100]  # Verschiedene Gitterpunktzahlen
table_data = zeros(Float64, length(Ns), 10)

for (i,N) in enumerate(Ns)
    table_data[i, 2] = 32/15
    table_data[i, 5] = 0  # Integral von sin(πx) von -1 bis 1
    table_data[i, 8] = 2  # Integral von |x| von -1 bis 1
    table_data[i, 1] = N
    # Funktion f1
    x = diskretisiere(-1, 1, N)
    y = f3.(x)
    a_coeffs_f3 = finde_koeffizienten(x, y)
    I_num_f3 = integriere_polynom(-1, 1, a_coeffs_f3)
    fehler_f3 = abs(I_num_f3 - table_data[i, 2])
    table_data[i, 3] = I_num_f3
    table_data[i, 4] = fehler_f3
    
    # Funktion f2
    y = g3.(x)
    a_coeffs_g3 = finde_koeffizienten(x, y)
    I_num_g3 = integriere_polynom(-1, 1, a_coeffs_g3)
    fehler_g3 = abs(I_num_g3 - table_data[i, 5])
    table_data[i, 6] = I_num_g3
    table_data[i, 7] = fehler_g3
    
    # Funktion f3
    y = h3.(x)
    a_coeffs_h3 = finde_koeffizienten(x, y)
    I_num_h3 = integriere_polynom(-1, 1, a_coeffs_h3)
    fehler_h3 = abs(I_num_h3 - table_data[i, 8])
    table_data[i, 9] = I_num_h3
    table_data[i, 10] = fehler_h3
end

header = ["N", "f Exakt","f Numerisch", "f Fehler","g Exakt" ,"g Numerisch", "g Fehler","h Exakt", "h Numerisch", "h Fehler"]
pretty_table(table_data; header=(header,), formatters=ft_printf("%.4e", [3,4,6,7,9,10]), title="Vergleich der Determinanten")