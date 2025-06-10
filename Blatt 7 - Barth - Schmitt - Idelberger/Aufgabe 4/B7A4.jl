using Plots
using LinearAlgebra

function P_k(n, x)
    if n == 0
        return 1.0
    elseif n == 1
        return x
    else
        return 1/n*((2n - 1)*x*P_k(n-1, x)-(n - 1)*P_k(n-2, x)) #Formel aus dem Skript für P_n+1 wobei n->n-1
    end
end


function P_k_abl(n, x)
    return ((2n-1)(P_k(n-1,x)+x*P_k_abl(n-1,x))-(k-1)P_k_abl(k-2,x))
end
