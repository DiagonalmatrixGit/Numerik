using LinearAlgebra


#opertornorm 1 und Inf:

function operatornorm(M::Matrix{Float64}, n) #n=Dimension, für 1 setze n=1, für unendlich setze n=2      
    return maximum(sum(M; dims=n))
end


#opertornorm F:

function matrix_qaudr(M::Matrix{Float64})
    M2 = similar(M)
    for i in 1:size(M, 1), j in 1:size(M, 2)
        M2[i, j] = M[i, j]^2
    end
    return M2
end


function operatornorm_F(M::Matrix{Float64}) #n=Dimension, für 1 setze n=1, für unendlich setze n=2     
    return sqrt(sum(matrix_qaudr(M)))
end


function Matrix_H(n)
    H = zeros(Float64, n, n)            #ertsellt eine nxn Matrix mit 0er Einträgen
    for i in 1:n
        for j in 1:n
            H[i, j] = 1 / (i + j - 1)
        end
    end
    return H
end



for i in 1:10
    r = rand(5:15)
    println(r)
    Hi = Matrix_H(r)
    println("Op_1: ",operatornorm(Hi, 1))
    println("Op_Inf: ",operatornorm(Hi, 2))    
    println("Op_F: ",operatornorm_F(Hi))    
end