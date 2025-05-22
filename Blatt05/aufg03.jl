using Plots

# (i) DFT Implementierung
function DFT(fx)
    N = length(fx)
    F = ComplexF64[]
    for k in 0:N-1
        sum_k = 0.0 + 0.0im
        for j in 0:N-1
            sum_k += fx[j+1] * exp(-2π*im * k * j / N)
        end
        push!(F, sum_k)
    end
    return F
end

# Anzahl der Punkte
N = 128
x = range(-π, π, length=N+1)[1:end-1]  # äquidistante, periodische Punkte

# (i) Harm. Funktion f(x) = sin(3x)
f = sin.(3 .* x)
F = DFT(f)
ks = 0:N-1

p1 = plot(ks, abs.(F), label="|F(k)|", title="DFT von sin(3x)", xlabel="k", ylabel="Betrag")

# (ii) Rechtecksignal sgn(sin(5t))
rect = sign.(sin.(5 .* x))
F_rect = DFT(rect)

p2 = plot(ks, abs.(F_rect), label="|F(k)|", title="DFT Rechtecksignal sgn(sin(5t))", xlabel="k", ylabel="Betrag")

# Plots nacheinander anzeigen
display(p1)
display(p2)