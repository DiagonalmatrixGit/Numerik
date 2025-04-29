#import PKG
#PKG.add("Plots")

#using Plots


function fx(x::Float64)
    return exp(x)
end

function gx(x::Float64)
    return sin(pi*x)
end

function hx(x::Float64)
    return x - 0.5
end

function bernstein(f::function, n::Int, x::Float64)
    sum = 0.0
    for i in 0:n
        s = s + f(i/n)*binomial(n,i) *x^i * (1-x)^(n-i)
    end
    return s
end





