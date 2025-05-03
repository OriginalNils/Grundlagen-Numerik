using Plots

function aufg01(N,M,m)

    # Runge-Funktion
    runge(x) = 1 / (1 + 25x^2)

    function diskretisiere(N, M)
        N % M == 0 || error("N muss ein Vielfaches von M sein.")
        return range(-1, 1, length=N+1)
    end
    
    function lagrange_local(x_nodes, f_nodes, x_eval)
        n = length(x_nodes)
        L = zero(x_eval)
        for j = 1:n
            l_j = ones(size(x_eval))
            for k = 1:n
                if k != j
                    l_j .*= (x_eval .- x_nodes[k]) / (x_nodes[j] - x_nodes[k])
                end
            end
            L .+= f_nodes[j] * l_j
        end
        return L
    end

    # Hauptfunktion zum Plotten
    function plot_stueckweise_interpolation(N, M, m; output_folder="output")
        x_grid = collect(diskretisiere(N, M))
        f_grid = runge.(x_grid)

        isdir(output_folder) || mkpath(output_folder)

        # Plot 1: Mit Runge-Funktion    
        plt1 = plot(runge, -1, 1, label="Runge-Funktion", lw=2)

        # Speicher für Plot 2: nur Interpolation
        plt2 = plot(title="Stückweise Lagrange-Interpolation", xlabel="x", ylabel="f(x)")

        # Interpolation in jedem Subintervall
        sublen = div(N, M)
        for s = 1:M
            i_start = (s - 1) * sublen + 1
            i_end = i_start + m
            if i_end > length(x_grid)
                continue  # nicht genug Punkte für m+1 Stützstellen
            end

            x_nodes = x_grid[i_start:i_end]
            f_nodes = f_grid[i_start:i_end]

            # Lokales feines Gitter für Auswertung
            x_local = range(x_nodes[1], x_nodes[end], length=100)
            y_local = lagrange_local(x_nodes, f_nodes, x_local)

            # Plotten
            plot!(plt1, x_local, y_local, label="", lw=2, color=:red)
            plot!(plt2, x_local, y_local, label="", lw=2, color=:blue)
        end

        # Speichern der Plots
        savefig(plt1, joinpath(output_folder, "plot1_runge_interpolation.png"))
        savefig(plt2, joinpath(output_folder, "plot2_interpolation_only.png"))

        println("Plots gespeichert in Ordner: $output_folder")
    end
    plot_stueckweise_interpolation(N, M, m)
end

function aufg02(N, M; output_folder="output")
    # Runge-Funktion
    runge(x) = 1 / (1 + 25x^2)

    # Gitter wie in aufg01
    function diskretisiere(N, M)
        N % M == 0 || error("N muss ein Vielfaches von M sein.")
        return collect(range(-1, 1, length=N+1))
    end

    # Ursprüngliches Gitter und Funktionswerte
    x = diskretisiere(N, M)
    f = runge.(x)

    # Lineare Spline-Plot
    plt = plot(x, f, label="Lineare Spline-Approximation", lw=2, color=:red, marker=:circle)
    plot!(runge, -1, 1, label="Runge-Funktion", lw=2, color=:blue, linestyle=:dash)

    # Intervallmittelpunkte berechnen
    x_mid = [(x[i] + x[i+1])/2 for i in eachindex(x[1:end-1])]

    # Spline-Auswertung an den Mittelwerten
    f_spline_mid = Float64[]
    for i in eachindex(x[1:end-1])
        xi, xi1 = x[i], x[i+1]
        fi, fi1 = f[i], f[i+1]
        t = (x_mid[i] - xi) / (xi1 - xi)
        push!(f_spline_mid, (1 - t)*fi + t*fi1)
    end

    # Exakte Werte und Fehler
    f_exact_mid = runge.(x_mid)
    fehler = abs.(f_spline_mid .- f_exact_mid)

    # Fehlerplot
    plt_error = plot(x_mid, fehler, label="|Spline - Runge|", lw=2, color=:green,
        title="Absoluter Fehler an Intervallmittelpunkten", xlabel="x", ylabel="Fehler")

    # Speichern
    isdir(output_folder) || mkpath(output_folder)
    savefig(plt, joinpath(output_folder, "plot3_linearspline_vs_runge.png"))
    savefig(plt_error, joinpath(output_folder, "plot4_spline_error_midpoints.png"))

    println("Spline-Plot und Fehlerplot gespeichert in $output_folder.")
end


