using Plots
using LinearAlgebra
using Polynomials

q(x) = 3*x^3 + 9*x^2 - 12
coeffsq = [3,9,0,-12]
qabl(x) = 9*x^2 + 18*x
u(x) = 5*x^4 + 12.5*x^3 - 12.5*x^2 + 12.5*x - 17.5
coeffsu = [5,12.5,-12.5,12.5,-17.5]
uabl(x) = 4*x^3 + 12.5*x^2 - 12.5*x + 12.5

function zeros_begleit(coeffs)
    deg = length(coeffs) - 1
    coeff_norm = coeffs ./ coeffs[1]
    A = zeros(deg, deg)
    for i in 1:deg
        if i != deg
            A[i+1, i] = 1
        end
        A[i, deg] = - coeff_norm[deg - i+2]
    end
    return eigvals(A)
end

function newton(x0, f,fabl, iter)
    x = x0
    if iter == 0
        return x
    end
    for _ in 1:iter
        x = x - f(x)/fabl(x)
    end
    return x
end

new_zeros_q = [newton(-2.1,q,qabl,20), newton(-1.5,q,qabl,20), newton(0.5,q,qabl,20)]
println("Nullstellen mit Newton von q(x): ",new_zeros_q)

println("Nullstellen über Begleitmatrix von q(x): ", zeros_begleit(coeffsq))

new_zeros_u = [newton(-3.4999,u,uabl,50), newton(1.00001,u,uabl,50)]
println("Nullstellen mit Newton von u(x): ", new_zeros_u)

println("Nullstellen über Begleitmatrix von u(x): ", zeros_begleit(coeffsu))

p1 = plot(q, -10, 10, label="q(x)")
p2 = plot(u, -10, 10, label="u(x)")
display(p1)
display(p2)