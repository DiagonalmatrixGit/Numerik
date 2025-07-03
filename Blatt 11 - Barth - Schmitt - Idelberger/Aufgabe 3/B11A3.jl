#using Pkg; Pkg.instantiate(); Pkg.activate(@__DIR__); Pkg.add(["Plots"]);
using Plots
using LinearAlgebra



function Matrix_H(lambda_max, lambda_min, n)

    lambda = collect(range(lambda_min, lambda_max, n))

    D = Diagonal(lambda)
    Q, _ = qr(randn(ComplexF64, n, n))
    H = Q * D * adjoint(Q)     

    return H
end




function cholesky(A::Matrix)

    n = size(A,1)

    L = zeros(eltype(A),n, n)       #passt Datentyp (hier ComplexF64) an die eingehende Matrix A an.

    for i in 1:n
        for j in 1:i    

            sum = 0
            for k in 1:j-1
                sum += L[i,k] * conj(L[j,k])
            end

            if i == j                                  #i = j
                L[i,i] = sqrt(A[i,i] - sum)

            else                                       #i > j
                L[i,j] = (A[i,j] - sum) / L[j,j]
            end
        end
    end
    return L
end



function Spektrum(H::Matrix{ComplexF64})

    LUZ = lu(H, NoPivot())
    L = LUZ.L
    U = LUZ.U

    C = cholesky(H)

    eig_H = eigvals(H)
    eig_LU = eigvals(L*U)
    eig_Chol = eigvals(C*adjoint(C))                # L von Cholesky

    plot(real(eig_H), imag(eig_H), seriestype=:scatter, label="H", legend=:bottomright)

    scatter!(real(eig_LU), imag(eig_LU), label="LU")
    scatter!(real(eig_Chol), imag(eig_Chol), label="Cholesky")

    xlabel!("Re")
    ylabel!("Im")

end


function condition_number_spectral_norm(eigenvalues)
    return maximum(abs.(eigenvalues)) / minimum(abs.(eigenvalues))
end




#Auswertung:
n = 200

# Lambda 1
l_max = 10^2
l_min = 10^(-4)
lambda = collect(range(l_min, l_max, n))


kond = condition_number_spectral_norm(lambda)
println("Konditionszahl:",kond)


H = Matrix_H(l_max, l_min, n)
Spektrum(H)
savefig(joinpath(@__DIR__, "l1.png"))

# lamda 2
l_max = 1.0
l_min = 2.0

lambda = collect(range(l_min, l_max, n))

kond = condition_number_spectral_norm(lambda)
println("Konditionszahl:",kond)


H = Matrix_H(l_max, l_min, n)
Spektrum(H)
savefig(joinpath(@__DIR__, "l2.png"))