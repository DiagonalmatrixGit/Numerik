using LinearAlgebra

function x_nplus1(x0::Float64, S::Float64, n::Int)
    if n == 0
        return x0
    else
        k = x_nplus1(x0, S, n - 1)
        return (k + S / k) / 2
    end
end

x_nplus1(2.0, 4.0, 5.0)

