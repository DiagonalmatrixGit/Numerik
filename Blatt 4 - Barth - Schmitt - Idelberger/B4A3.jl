using Pkg
#Pkg.instantiate(); Pkg.activate(@__DIR__); Pkg.add("LinearSolve"); 
using LinearSolve 


#Implemetierung der Funktionen und erzeugung regelmäßiger Interpolationspunkte für g und f

function fx(x::Float64)
    return sin(2*pi*x)
end

function gx(x::Float64)
    return cos(exp(x))
end


N=10
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
        b[i] = 3 * ((y[i+1] - y[i]) * D[i-1]/D[i] - (y[i] - y[i-1]) * D[i]/D[i-1])
    end
    return b
end






A = MatrixA(xGitter)
b_f = Vektor_b(xGitter, y_f)
b_g = Vektor_b(xGitter, y_g)


prob = LinearProblem(A, b_f)
sol = solve(prob)
println("Auswertung für f(x): ",sol.u)  

prob = LinearProblem(A, b_g)
sol = solve(prob)
println("Auswertung für g(x): ",sol.u)  



