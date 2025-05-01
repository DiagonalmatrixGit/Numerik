
#Vandermondematrix
function VMatrix(x::Vector)
    n = length(x)
    V = zeros(n,n)
    for i in 1:n, j in 1:n
        V[i,j] = x[i]^(j-1)      
    end
    return V
end


#Determinante
function VDet(x::Vector)
    n = length(x)
    prod = 1
    for i in 1:n, j in (i+1):n
        prod = prod * (x[j]-x[i])
    end
    result = prod
end



using LinearAlgebra

test=[1,2,3,4]
println(test[2])

println(VMatrix(test))
println(VDet(test))
println(det(VMatrix(test)))

