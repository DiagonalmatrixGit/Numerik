using Pkg
Pkg.instantiate(); Pkg.activate(@__DIR__); Pkg.add("LinearSolve"); 
using LinearSolve 
using Plots



#Implemetierung der Funktionen und erzeugung regelmäßiger Interpolationspunkte für g und f

function fx(x::Float64)
    return sin(2*pi*x)
end

function gx(x::Float64)
    return cos(exp(x))
end


N=100
xGitter = collect(range(-1, 1, N))
y_f = fx.(xGitter)
y_g = gx.(xGitter)


# Delta x_i = x_i+1 - x_i
function deltaX(x::AbstractVector)
    n = length(x)
    Del = similar(x, n-1)           #leerer Vektor der Länge n-1

    for i in 1:n-1
        Del[i] = x[i+1]-x[i]
    end
    return Del
end


function MatrixA(x::AbstractVector)
    n = length(x)
    A = zeros(n, n)

    D = deltaX(x)

    #Randbedingungen
    A[1,1] = 2*D[1]
    A[1,2] = D[1]
    A[end,end-1] = D[end]
    A[end,end] = 2*D[end]

    for i in 2:(n-1)
        A[i,i-1] = D[i]
        A[i,i]   = 2*(D[i] + D[i-1])
        A[i,i+1] = D[i-1]
    end
    return A
end


function Vektor_b(x::AbstractVector, y::AbstractVector)
    n = length(x)
    b = zeros(n)
    D = deltaX(x)

    b[1]   = 3 * (y[2] - y[1])
    b[end] = 3 * (y[end] - y[end-1])

    for i in 2:(n-1)
        b[i] = 3 * ((y[i+1] - y[i]) * D[i-1]/D[i] + (y[i] - y[i-1]) * D[i]/D[i-1])
    end
    return b
end



function spline(x_fest::Float64, x::AbstractVector, y::AbstractVector, sig::AbstractVector)
    D = deltaX(x)
    n = length(x)

    #Einordnung ins Intervall [x_k, x_k+1]
    i = findfirst(k -> x[k] <= x_fest < x[k+1], 1:n-1)
    if i === nothing
        i = n - 1
    end

    d = x_fest - x[i]
    c2 = (3y[i+1] - 3y[i] - 2*sig[i]*D[i] - sig[i+1]*D[i]) / D[i]^2
    c3 = (-2y[i+1] + 2y[i] + sig[i]*D[i] + sig[i+1]*D[i]) / D[i]^3

    return y[i] + sig[i]*d + c2*d^2 + c3*d^3
end


#Auswertung


A = MatrixA(xGitter)
b_f = Vektor_b(xGitter, y_f)
b_g = Vektor_b(xGitter, y_g)



prob = LinearProblem(A, b_f)
sol = solve(prob)
sigma_f = sol.u


prob = LinearProblem(A, b_g)
sol = solve(prob)
sigma_g = sol.u


#hab noch nicht so ganz verstanden was ich eigentlich mit den Si´s mache, ich glaube der Rest ist bisschen falsch


# Gitter für glatte Darstellung
x_dense = range(-1, 1, length=100)                                   #Eigentlich wollte ich mehr Punkte wählen, aber dann kommt es zu einem BoundsError
y_spline_f = [spline(xi, xGitter, y_f, sigma_f) for xi in x_dense]
y_spline_g = [spline(xi, xGitter, y_g, sigma_g) for xi in x_dense]

# Analytische Ableitungen
df(x) = 2π * cos(2π*x)
dg(x) = -sin(exp(x)) * exp(x)

y_df = df.(x_dense)
y_dg = dg.(x_dense)


p1= plot(x_dense, y_spline_f, label="Spline f(x)", lw=1)
plot!(p1, x_dense, y_f, label="Original f(x)", linestyle=:dash, lw=2)
plot!(p1, xlabel="x", ylabel="y")

p2=plot(x_dense, y_spline_g, label="Spline g(x)", lw=1)
plot!(p2, x_dense, gx.(x_dense), label="Original g(x)", linestyle=:dash, lw=2)
plot!(p2, xlabel="x", ylabel="y")

p3=plot(x_dense, y_df, label="Analytische Ableitung f(x)", lw=2)
plot!(p3, xlabel="x", ylabel="f'(x)")

p4=plot(x_dense, y_dg, label="Analytische Ableitung g(x)", lw=2)
plot!(p4,xlabel="x", ylabel="g'(x)")


plot(p1, p2,p3, p4, layout=(2,2), size=(1000,1000))
savefig(joinpath(@__DIR__, "Eregbnis.png"))
