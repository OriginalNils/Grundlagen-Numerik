using DelimitedFiles
using LinearAlgebra

# --- (i) Daten einlesen ---
file = "Blatt05/data_cubic_clamped.txt"
data = readdlm(file, '\t', skipstart=1)
t = data[:, 1]
x = data[:, 2]
y = data[:, 3]

tmin = minimum(t)
tmax = maximum(t)
t_eval = range(tmin, stop=tmax, length=100)

function cubic_spline_clamped(t, y_vals)
    n = length(t)
    h = diff(t)
    d = zeros(n)
    u = zeros(n-1)
    l = zeros(n-1)
    b = zeros(n)

    for i in 1:n
        if i == 1
            l[1] = h[2]
            d[1] = 3
            b[1] = 0
            continue
        elseif i == n
            d[n] = 3
            b[n] = 0
            break
        elseif i == n-1
            l[i] = 0
            d[i] = 2*(h[i-1]+h[i])
            u[i] = h[i-1]
        else        
            d[i] = 2*(h[i-1]+h[i])
            l[i] = h[i+1]
            u[i] = h[i-1]
            b[i] = 3*(y_vals[i+1]-y_vals[i])*(h[i-1]/h[i]) + 3*(y_vals[i]-y_vals[i-1])*(h[i]/h[i-1])
        end
    end

    A = Tridiagonal(l, d, u)
    return A \ b
end

function i_cubic_spline(t, y_vals, i)
    sigma = cubic_spline_clamped(t, y_vals)
    h = diff(t)
    c0 = y_vals[i]
    c1 = sigma[i]
    c2 = (3*y_vals[i+1]-3*y_vals[i]-2*sigma[i]*h[i]-sigma[i+1]*h[i])/(h[i]^2)
    c3 = (-2*y_vals[i+1]+2*y_vals[i]+sigma[i]*h[i]+sigma[i+1]*h[i])/(h[i]^3)

    return x -> c0 + c1*(x - t[i]) + c2*(x-t[i])^2 + c3*(x-t[i])^3
end

# Funktion um Spline an Punkten auszuwerten
function spline_eval(ti, vi, t_eval)
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
            cube_spl = i_cubic_spline(ti, vi, i)
            v_eval[j] = cube_spl(t_val)
        end
    end
    return v_eval
end


x_vals = spline_eval(t,x,t_eval)
y_vals = spline_eval(t,y,t_eval)

# --- (iii) Ergebnis speichern ---
result = [t_eval x_vals y_vals]
output_file = "Blatt05/data_cubic_clamped_sol.txt"
open(output_file, "w") do io
    write(io, "# t x y\n")
    writedlm(io, result, '\t')
end
