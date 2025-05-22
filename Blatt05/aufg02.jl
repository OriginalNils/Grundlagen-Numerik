using DelimitedFiles

# --- (i) Daten einlesen ---
file = "Blatt05/data_cubic_clamped.txt"
data = readdlm(file, '\t', skipstart=1)
t = data[:, 1]
x = data[:, 2]
y = data[:, 3]

# Hilfsfunktion: Kubische Spline-Koeffizienten mit clamped Randbedingungen berechnen
function cubic_spline_clamped(t, f)
    n = length(t)
    h = diff(t)
    b = zeros(n)
    u = zeros(n)
    v = zeros(n)
    z = zeros(n)

    # Aufbau des linearen Systems für zweite Ableitungen (M)
    alpha = zeros(n)
    # Randbedingungen: f'(t0) = 0 und f'(tn) = 0
    alpha[1] = 3*( (f[2]-f[1])/h[1] - 0 )
    alpha[n] = 3*( 0 - (f[n]-f[n-1])/h[n-1] )
    for i in 2:n-1
        alpha[i] = 3*( (f[i+1]-f[i])/h[i] - (f[i]-f[i-1])/h[i-1] )
    end

    l = ones(n)
    mu = zeros(n)
    z = zeros(n)

    # Vorwärtsdurchlauf
    for i in 2:n-1
        l[i] = 2*(t[i+1] - t[i-1]) - h[i-1]*mu[i-1]
        mu[i] = h[i] / l[i]
        z[i] = (alpha[i] - h[i-1]*z[i-1]) / l[i]
    end

    # Randbedingungen in l und z anpassen
    l[1] = 2*h[1]
    l[n] = 2*h[n-1]

    # Rückwärtssubstitution
    c = zeros(n)
    b = zeros(n-1)
    d = zeros(n-1)
    a = f[1:end-1]

    c[n] = z[n]
    for j in (n-1):-1:1
        c[j] = z[j] - mu[j]*c[j+1]
        b[j] = (f[j+1]-f[j])/h[j] - h[j]*(c[j+1] + 2*c[j])/3
        d[j] = (c[j+1] - c[j]) / (3*h[j])
    end

    return a, b, c[1:end-1], d, t
end

# Funktion um Spline an Punkten auszuwerten
function spline_eval(a,b,c,d,t_spline,x_spline)
    n = length(a)
    y = zeros(length(x_spline))
    for (k, xx) in enumerate(x_spline)
        # Intervall finden
        i = searchsortedlast(t_spline, xx)
        i = clamp(i,1,n)
        dx = xx - t_spline[i]
        y[k] = a[i] + b[i]*dx + c[i]*dx^2 + d[i]*dx^3
    end
    return y
end

# --- (ii) Koeffizienten für x und y berechnen ---
a_x, b_x, c_x, d_x, ts = cubic_spline_clamped(t, x)
a_y, b_y, c_y, d_y, ts = cubic_spline_clamped(t, y)

# Neue Stützstellen
t_vals = range(minimum(t), maximum(t), length=100)

# Werte ausrechnen
x_vals = spline_eval(a_x, b_x, c_x, d_x, ts, t_vals)
y_vals = spline_eval(a_y, b_y, c_y, d_y, ts, t_vals)

# --- (iii) Ergebnis speichern ---
result = [t_vals x_vals y_vals]
output_file = "Blatt05/data_cubic_clamped_sol.txt"
open(output_file, "w") do io
    write(io, "# t x y\n")
    writedlm(io, result, '\t')
end
