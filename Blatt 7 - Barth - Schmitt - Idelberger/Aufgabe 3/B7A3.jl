using LinearAlgebra

function Tridiagonalmatrix(n::Int64)

    A = zeros(n+1, n+1)             #folglich müssen die ak nicht weiter implemntiert werden.

    for i in 2:n+1
        A[i, i-1] = sqrt(1/2)
        A[i-1, i] = sqrt(1/2)
    end

    return A
end



function KnotenGewichte(n::Int64)
    E = eigen(Tridiagonalmatrix(n))
    knoten = E.values
    eigenvektor = E.vectors

    gewichte = [(sqrt(pi) *eigenvektor[1,k]^2) for k in 1:length(knoten)] # beta0 = sqrt(pi)

    return knoten, gewichte
end



function GaussQuad(f::Function, xk, wk)
    n = length(xk)
    return sum(wk[i] * f(xk[i]) for i in 1:n)
end



function test(n)
    nodes, weights = KnotenGewichte(n)

    for k in 0:8
        f = x -> x^k
        approx = GaussQuad(f, nodes, weights)
        exact = [sqrt(pi), 0,sqrt(pi)/2, 0, sqrt(pi)*3/4, 0, sqrt(pi)*15/8, 0,sqrt(pi)*105/16 ]
        println("k: ",k," Gauß: ", approx,"     Exakt: ", exact[k+1], "     Fehler: ", approx-exact[k+1])

    end
end

test(4)



