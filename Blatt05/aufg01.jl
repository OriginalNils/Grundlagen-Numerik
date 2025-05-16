using DelimitedFiles

# 1. Daten einlesen
data, header = readdlm("Blatt05/data_linear.txt", '\t', header=true)
t = data[:, 1]
x = data[:, 2]
y = data[:, 3]

# 2. Neue Stützstellen generieren
tmin = minimum(t)
tmax = maximum(t)
t_eval = range(tmin, stop=tmax, length=100)

# 3. Lineare Interpolation manuell implementieren
function linear_spline(ti, vi, t_eval)
    n = length(ti)
    v_eval = similar(t_eval)
    for (j, t_val) in pairs(t_eval)
        # Intervall finden: ti[i] ≤ t_val ≤ ti[i+1]
        i = findlast(i -> ti[i] ≤ t_val, 1:n-1)
        if i === nothing
            # vor erstem Punkt → konstant extrapolieren
            v_eval[j] = vi[1]
        elseif t_val > ti[end]
            # nach letztem Punkt → konstant extrapolieren
            v_eval[j] = vi[end]
        else
            # Interpolation im Intervall [ti[i], ti[i+1]]
            t0, t1 = ti[i], ti[i+1]
            v0, v1 = vi[i], vi[i+1]
            slope = (v1 - v0) / (t1 - t0)
            v_eval[j] = v0 + slope * (t_val - t0)
        end
    end
    return v_eval
end

# 4. Interpolationen auswerten
x_eval = linear_spline(t, x, t_eval)
y_eval = linear_spline(t, y, t_eval)

# 5. Ergebnisse zusammenfassen
result = hcat(t_eval, x_eval, y_eval)

# 6. Datei schreiben
open("Blatt05/data_linear_sol.txt", "w") do io
    write(io, "# t x y\n")
    writedlm(io, result, '\t')
end
