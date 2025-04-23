using LinearAlgebra

function operatornorm(M::Matrix{Float64}, n) #n=Dimension, für 1 setze n=1, für unendlich setze n=2
    println(sum(M, dims=n))        
    return maximum(sum(M; dims=n))
end




function matrix_qaudr(M::Matrix{Float64})
    M2 = similar(M)  # erstellt eine Matrix gleicher Größe & Typs
    for i in 1:size(M, 1), j in 1:size(M, 2)
        M2[i, j] = M[i, j]^2
    end
    return M2
end


function operatornorm_F(M::Matrix{Float64}) #n=Dimension, für 1 setze n=1, für unendlich setze n=2
    println(sum(matrix_qaudr(M)))        
    return sqrt(sum(matrix_qaudr(M)))
end


#Test:
A = [1.0 1.0 1.0; 1.0 2.0 1.0; 1.0 3.0 1.0]
operatornorm(A,1)
operatornorm(A,2)
operatornorm_F(A)