using BenchmarkTools
using PrettyTables

# Rechte Seite der DGL
function f(u, λ)
    return -λ * u^2
end

# Explizite Mittelpunktsregel
function midpoint_explicit(λ; Δt=0.01, Tsteps=1000)
    u = 1.0                    # Anfangswert
    t = 0.0                    # Startzeit
    history = [u]             # Für Plot

    for n in 1:Tsteps
        u1 = u + (Δt/2) * f(u, λ)
        u = u + Δt * f(u1, λ)
        push!(history, u)
        t += Δt
    end

    return history
end

function midpoint_implicit(λ; Δt=0.01, Tsteps=1000)
    u = zeros(Tsteps + 1)
    u[1] = 1.0  # Anfangswert

    f(u) = -λ * u^2
    df(u) = -2λ * u  # Ableitung von f(u)

    for n in 1:Tsteps
        # Newton-Iteration zur Bestimmung von u^(1)
        u_old = u[n]
        u1 = u_old  # Startwert für Newton

        for _ in 1:1000
            F = u1 - u_old - (Δt / 2) * f(u1)
            dF = 1 - (Δt / 2) * df(u1)
            u1 -= F / dF
        end

        # Zeitschritt aktualisieren
        u[n+1] = u[n] + Δt * f(u1)
    end

    return u
end


# Zeitmessung + Vergleich mit exakter Lösung
function run_all_lambdas()
    header = ["λ", "Max Fehler", "Laufzeit (ms)"]
    lambdas = [1, 10, 50, 100, 150, 300, 400, 500]
    table_data = zeros(Float64, length(lambdas), 3)
    Δt = 0.01
    Tsteps = 1000
    T = Δt * Tsteps
    tgrid = 0:Δt:T

    for (i, l) in enumerate(lambdas)
        table_data[i, 1] = l

        elapsed = @elapsed u_num = midpoint_explicit(l; Δt=Δt, Tsteps=Tsteps)
        elapsed_ms = elapsed * 1000  # Sekunden → Millisekunden

        u_exact = [1 / (l * t + 1) for t in tgrid]
        err = maximum(abs.(u_num .- u_exact))

        table_data[i, 2] = err
        table_data[i, 3] = elapsed_ms
    end
    pretty_table(table_data; header=header, formatters=ft_printf("%.4e", 2:3), title="Zeit und Fehler Mittelpunktsregel", compact_printing = false, crop = :none)
end

function run_all_lambdas_implicit()
    lambdas = [1, 10, 50, 100, 150, 300, 400, 500]
    table_data = zeros(Float64, length(lambdas), 3)
    Δt = 0.01
    Tsteps = 1000
    T = Δt * Tsteps
    tgrid = 0:Δt:T
    header = ["λ", "Max Fehler", "Laufzeit (ms)"]

    for (i,l) in enumerate(lambdas)
        elapsed = @elapsed u_num = midpoint_implicit(l; Δt=Δt, Tsteps=Tsteps)
        elapsed_ms = elapsed * 1000

        u_exact = [1 / (l * t + 1) for t in tgrid]
        err = maximum(abs.(u_num .- u_exact))

        table_data[i, 1] = l
        table_data[i, 2] = err
        table_data[i, 3] = elapsed_ms
    end
    pretty_table(table_data; header=header, formatters=ft_printf("%.4e", 2:3), title="Zeit und Fehler (implizite Mittelpunktsregel)", compact_printing = false, crop = :none)
end


run_all_lambdas()
run_all_lambdas_implicit()