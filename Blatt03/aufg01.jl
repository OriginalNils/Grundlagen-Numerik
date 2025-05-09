using Plots

N = 60
M = 15
m = 3

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
function plot_stueckweise_interpolation(N, M, m)
    x_grid = collect(diskretisiere(N, M))
    f_grid = runge.(x_grid)

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

    display(plt1)
    display(plt2)
end
plot_stueckweise_interpolation(N, M, m)