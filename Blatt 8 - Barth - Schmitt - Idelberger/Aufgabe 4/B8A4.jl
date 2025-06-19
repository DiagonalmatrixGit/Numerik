#using Pkg; Pkg.instantiate(); Pkg.activate(@__DIR__); Pkg.add(["Plots"]);
using Plots
using LinearAlgebra

function q(x)
    return 3x^3 + 9x^2 - 12
end

function u(x)
    return 5x^4 + 12.5x^3 - 12.5x^2 + 12.5x - 17.5
end

x = collect(range(-10, 10, 100))

y_q = [q(i) for i in x]
y_u = [u(i) for i in x]

plot(x, y_q, label="q(x)", title="Polynome q und u")
plot!(x, y_u, label="u(x)")
xlabel!("x")
ylabel!("y")
savefig(joinpath(@__DIR__, "Plot1.png"))



# begleitmatrix
function BeglMatr(p)
    n = length(p)
    A = zeros(n, n)

    for i in 1:n-1
        A[i+1, i] = 1
    end
    
    A[:, n] = -p[1:n]   #vgl. a_0 bis a_n-1 aber 1:n
    return A
end


#Normieren und auswerten Auswerten
q_ak = [-4,0, 3]  #normiert: a_0, a_1, ...
u_ak = [-17.5/5, 12.5/5, -12.5/5, 12.5/5] 

A_q = BeglMatr(q_ak)
A_u = BeglMatr(u_ak)

println("Mit Begleitmatrix")
println("Nullstellen von q(x):", eigvals(A_q))
println("Nullstellen von u(x):", eigvals(A_u))
println()





#(iv)Auswertung mit Newton

function dq(x)
    return 6x^2 + 18x - 12
end

function du(x)
    return 20x^3 + 37.5x^2 - 25x + 12.5
end


function newton(f, df, x0, n)
    x = x0

    for i in 1:n
        x_next = x - f(x)/df(x)
        x = x_next
    end

    return x
end


startwerte_q = collect(range(-5, 5, 11))
startwerte_u = collect(range(-5, 5, 11))

println("Newtonverfahren")
println("Nullstellen q(x) mit Newton:", [newton(q, dq, x0, 200) for x0 in startwerte_q])
println("Nullstellen u(x) mit Newton:", [newton(u, du, x0, 200) for x0 in startwerte_u])
println()

#eigene Ergänzung für die (v)
println("Newtonverfahren")
println("Nullstellen q(x) mit Newton:", [newton(q, dq, x0, 200) for x0 in [1.986, 0.842842, 0.9, 0.99]])