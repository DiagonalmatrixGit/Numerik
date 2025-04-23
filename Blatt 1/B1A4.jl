using LinearAlgebra

function x_nplus1(x0::Float64, S::Float64, n::Int)
    if n == 0
        return x0
    else
        k = x_nplus1(x0, S, n - 1)
        return (k + S/k)/ 2
    end
end



#Test:

println("Wurzel von S = 1/2: ", sqrt(1/2))

for i in 1:10
    xnull = rand(0.0:100.0)
    num = rand(0:100)

    println("x0: ", xnull)
    println("n: ", num)
    println("x_n: ",x_nplus1(xnull, 1/2, num))
    println("")
end



