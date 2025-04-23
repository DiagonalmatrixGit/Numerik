using LinearAlgebra

function Matrix_H(n)
    H = zeros(Float64, n, n)            #ertsellt eine nxn Matrix mit 0er Einträgen
    for i in 1:n
        for j in 1:n
            H[i, j] = 1 / (i + j - 1)
        end
    end
    return H
end


Matrix_H(2)
Matrix_H(3)