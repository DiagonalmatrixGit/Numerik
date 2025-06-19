using Pkg; Pkg.instantiate(); Pkg.activate(@__DIR__); Pkg.add(["BenchmarkTools"]);

using LinearAlgebra, BenchmarkTools


#(i)

function kahan_loesung(n, eps)

    x = zeros(Float64, n)
    b = [k for k in 1:n]
    
    for i in 1:n
        sum = 0.0     #sum(eps(i-j)*x(i))

        for j in 1:i-1
            sum +=eps^(i-j)*x[j]
        end

        x[i] = b[i]-sum

    end

    return x
end


#(ii + iii)

function kahan_matrix(n, eps)
    K = zeros(Float64, n, n)
    K[1,1] = 1

    for i in 2:n
        for j in 1:i-1
            K[i, j] = eps^(i-j)
        end
        K[i,i] = 1
    end
    return K
end


function b_n(n)
    return [k for k in 1:n]
end


println(kahan_matrix(4, 3))




epsilon = 4 * eps(Float64)
n_list = [5, 10, 20, 50, 100, 150, 200, 300, 500, 1000, 3000]





for k in n_list
    println("n = ", k)

    t1 = @belapsed kahan_loesung($k, $epsilon)
    println("Gauß: ",t1, "s" )

    t2 = @belapsed inv(kahan_matrix($k, $epsilon))*b_n($k)
    println("x = K^(-1) * b: ",t2, "s" )
end

