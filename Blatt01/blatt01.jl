using Printf
using Plots
using PrettyTables

function aufg01()
    function norm_1(A::AbstractMatrix)
        return maximum(sum(abs, A; dims=1))
    end
    
    function norm_inf(A::AbstractMatrix)
        return maximum(sum(abs, A; dims=2))
    end
    
    function norm_f(A::AbstractMatrix)
        return sqrt(sum(abs2, A))
    end
    
    # Hilbert-Matrix:
    function matrix_h(n::Int)
        H = zeros(n, n)
        for i in 1:n
            for j in 1:n
                H[i, j] = 1 / (i + j - 1)
            end
        end
        return H
    end

    # Datenmatrix vorbereiten:
    data = Matrix{Float64}(undef, 10, 4)

    for n in 1:10
        H = matrix_h(n)
        data[n, 1] = n
        data[n, 2] = norm_1(H)
        data[n, 3] = norm_inf(H)
        data[n, 4] = norm_f(H)
    end
    
    header = ["n", "‖H‖₁", "‖H‖∞", "‖H‖F"]
    pretty_table(data; header = (header,), title = "Normen der Hilbert-Matrix für n = 1 bis 10")
end

function aufg02(S)
    # Berechnung des n-ten Folgengliedes
    function nth_elem(x0, S, n)
        x = x0
        for i in 1:n
            x = 0.5 * (x + S / x)
        end
        return x
    end

    # Funktion zur Konvergenzanalyse
    function teste_konvergenz(S::Float64, x0_values::Vector{Float64}, n_values::Vector{Int})
        num_rows = length(x0_values)
        num_cols = length(n_values) + 1  # +1 für x₀
        table_data = zeros(Float64, num_rows, num_cols)

        for (i, x0) in enumerate(x0_values)
            table_data[i, 1] = x0  # Erste Spalte = x₀
            for (j, n) in enumerate(n_values)
                xn = nth_elem(x0, S, n)
                fehler = abs(xn - sqrt(S))
                table_data[i, j + 1] = fehler
            end
        end

        header = ["x₀", string.(n_values)...]  # z.B. ["x₀", "1", "2", "3", "5", "10"]
        pretty_table(table_data; header = (header,), title = "Konvergenz der Folge für S = $(S)")
    end

    # Beispielwerte für x0 und n
    x0_values = [0.1, 0.5, 1.0, 2.0, 10.0]
    n_values = [1, 2, 3, 5, 10]

    # Aufruf der Funktion für S = 0.5
    teste_konvergenz(S, x0_values, n_values)
end




function aufg03(N)
    h = 1 / (N + 1)  # Abstand zwischen den Punkten
    x = LinRange(0, 1, N + 2)  # Gitter von N+2 Punkten (inkl. Ghost Cells)

    function forward_diff_matrix(N, h)
        D_plus = zeros(N, N + 2)
        for i in 1:N
            D_plus[i, i+1] = -1/h
            D_plus[i, i+2] = 1/h
        end
        return D_plus
    end
    
    function backward_diff_matrix(N, h)
        D_minus = zeros(N, N + 2)
        for i in 1:N
            D_minus[i, i] = -1/h
            D_minus[i, i+1] = 1/h
        end
        return D_minus
    end
    
    function central_diff_matrix(N, h)
        D_central = zeros(N, N + 2)
        for i in 1:N
            D_central[i, i] = -1/(2h)
            D_central[i, i+2] = 1/(2h)
        end
        return D_central
    end    

    # Funktionstest – überprüft, ob f an allen x ausgewertet werden kann
    function check_function_evaluation(f, x)
        for xi in x
            try
                _ = f(xi)
            catch e
                println("Fehler bei der Auswertung der Funktion an x = $xi: $e")
                return false
            end
        end
        return true
    end

    # Plot-Funktion
    function plot_derivative(N, f, f_prime_exact; method="forward", name)
        h = 1 / (N + 1)
        x = LinRange(0, 1, N + 2)
        f_values = f.(x)

        # Differenzenmatrix auswählen
        D = nothing
        method_label = ""

        if method == "forward"
            D = forward_diff_matrix(N, h)
            method_label = "Vorwärtsdifferenz"
        elseif method == "backward"
            D = backward_diff_matrix(N, h)
            method_label = "Rückwärtsdifferenz"
        elseif method == "central"
            D = central_diff_matrix(N, h)
            method_label = "Zentrale Differenz"
        else
            error("Unbekannte Methode: '$method'. Erlaubt sind: 'forward', 'backward', 'central'")
        end

        D_values = D * f_values

        # Vergleich mit exakter Ableitung auf inneren Punkten x[2:N+1]
        f_prime_exact_values = f_prime_exact.(x[2:N+1])

        # Plot erstellen
        p = plot(x[2:N+1], D_values, label="Numerisch ($method_label)",
            xlabel="x", ylabel="f'(x)", title="Ableitung mit $method_label", lw=2)
        plot!(p, x[2:N+1], f_prime_exact_values, label="Exakte Ableitung", linestyle=:dash, lw=2)

        # Plot speichern
        savefig(string("output/", name, "_ableitung_", method, ".pdf"))
    end

    function konvergenztest(f, f_prime_exact; methode="central", Ns=10 .^ (1:4))
        errors = Float64[]
        hs = Float64[]
    
        for N in Ns
            h = 1 / (N + 1)
            x = LinRange(0, 1, N + 2)
            f_values = f.(x)
    
            # Differenzenmatrix auswählen
            D = methode == "forward"  ? forward_diff_matrix(N, h) :
                methode == "backward" ? backward_diff_matrix(N, h) :
                methode == "central"  ? central_diff_matrix(N, h) :
                error("Unbekannte Methode")
    
            Df_values = D * f_values
    
            # Interner Bereich: x[2:N+1]
            f_prime_values = f_prime_exact.(x[2:N+1])
            error_max = maximum(abs.(Df_values - f_prime_values))
    
            push!(errors, error_max)
            push!(hs, h)
        end
    
        # Konvergenzordnung (lineare Regression im log-log-Raum)
        slope = sum(log.(hs) .* log.(errors)) - sum(log.(hs)) * sum(log.(errors)) / length(hs)
        slope /= sum(log.(hs).^2) - (sum(log.(hs))^2) / length(hs)
        slope = round(slope, digits=2)

        # Plot ohne Referenzgerade
        p = plot(hs, errors, xscale=:log10, yscale=:log10,
            xlabel="h", ylabel="Fehler",
            title="Konvergenztest – Methode: $methode",
            label="Fehler (Ordnung ≈ $slope)",
            legend=:bottomright)

        savefig(p, string("output/konvergenz_", methode, ".pdf"))
    end
    

    # Testfunktion und exakte Ableitung
    f(x) = x^2
    f_prime_exact(x) = 2x
    g(x) = exp(x)
    g_prime_exact(x) = exp(x)

    plot_derivative(N, f, f_prime_exact, method="forward", name = f)
    plot_derivative(N, f, f_prime_exact, method="backward", name = f)
    plot_derivative(N, f, f_prime_exact, method="central", name = f)
    plot_derivative(N, g, g_prime_exact, method="forward", name = g)
    plot_derivative(N, g, g_prime_exact, method="backward", name = g)
    plot_derivative(N, g, g_prime_exact, method="central", name = g)

    f_t(x) = sin(x)
    f_t_prime(x) = cos(x)

    konvergenztest(f_t, f_t_prime; methode="forward")
    konvergenztest(f_t, f_t_prime; methode="backward")
    konvergenztest(f_t, f_t_prime; methode="central")
end