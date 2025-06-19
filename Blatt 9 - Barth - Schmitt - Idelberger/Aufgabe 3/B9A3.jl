using Pkg; Pkg.instantiate(); Pkg.activate(@__DIR__); Pkg.add(["PrettyTables", "InverseFunctions"]);
using LinearAlgebra
using PrettyTables
using InverseFunctions

function Hilbert(n)
    A = zeros(Float64, n, n)           
    for i in 1:n
        for j in 1:n
            A[i, j] = 1 / (i + j - 1)
        end
    end
    return A
end


function Hilbert_inv(n)
    A = Matrix{BigFloat}(undef, n, n)
    for i in 1:n
        for j in 1:n

            i = BigInt(i)
            j = BigInt(j)
            n = BigInt(n)


            zaehler = (-1)^(i + j) * factorial(i + n - 1) * factorial(j + n - 1)
            nenner = (factorial(i - 1))^2 * (factorial(j - 1))^2 * factorial(n - i) * factorial(n - j) * (i + j - 1)

            A[i, j] = BigFloat(zaehler) / BigFloat(nenner)
        end
    end
    return A
end


function Einheit(n)
    A = zeros(Float64, n, n)
    for i in 1:n
        A[i, i] = 1
    end
    return A
end



function R_norm(n)
    R = Hilbert(n) * Hilbert_inv(n) - Einheit(n)
    return norm(R, Inf)
end






#Auswertung (i)
n = [5,10,20,30,50,80]
for  i in 1:length(n)
    println(n[i], ": ", R_norm(n[i]))
end

#(ii):



function H_inv_software(H)
    return inv(H)
end


function Konditionszahl(H::Matrix, H_inv::Matrix)
        return norm(H, Inf) * norm(H_inv, Inf)
end


println("Analytisch:")
for  i in 1:length(n)
    println(n[i], ": Konditionszahl = ", Konditionszahl(Hilbert(n[i]), Hilbert_inv(n[i])))
end

println("Sofware:")
for  i in 1:length(n)
    println(n[i], ": Konditionszahl = ", Konditionszahl(Hilbert(n[i]), H_inv_software(Hilbert(n[i]))))
end