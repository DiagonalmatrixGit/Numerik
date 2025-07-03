using Pkg; Pkg.instantiate(); Pkg.activate(@__DIR__); Pkg.add(["Plots"]);

using LinearAlgebra


function T_matrix(n)
    T = zeros(Float64, n, n)   

    for i in 1:n
        T[i,i] = 4
    end

    for i in 1:(n-1)
        T[i,i+1] = -1
        T[i+1,i] = -1
    end

    return T
end


function Einheitsmatrix(n)
    M = zeros(Float64, n, n)
    for i in 1:n
        M[i,i] = 1
    end
    return M
end



function D_matrix(n)
    T = T_matrix(n)
    I = Einheitsmatrix(n)


    D = zeros(n^2, n^2)

    #T_matrizen auf der Diagonalen

    for i in 1:(n^2)
        D[i,i] = 4
    end

    for i in 1:(n^2 -1)
        D[i,i+1] = -1
        D[i+1,i] = -1
    end

    for i in 1:n-1
        k= i*n
        D[k,k+1] = 0
        D[k+1,k] = 0
    end

    #Einheitsmatrizen
    
    for i in 1:(n^2 -n)
        D[i+n,i] = -1
        D[i,i+n] = -1
    end    


    return D
end



function LU_Zerlegung(A)

    n = size(A,1)
    A_tilde = copy(A)
    L_list = Matrix{Float64}[]


    for k in 1:n-1   # Laüft alle Spalten A(., k) ab

        for i in k+1:n                          #Alle Zeileneinträge unter A(k,k)

            Li = Einheitsmatrix(n)
            Li[i,k] = - A_tilde[i,k] / A_tilde[k,k]

            push!(L_list, Li)                       #Erstellt eine Liste für L_1 bis L_n-1

            A_tilde = Li * A_tilde

        end
    end

    U = A_tilde

    # Erzeugt L aus den Inversen
    L = Einheitsmatrix(n)

    for i in 1:length(L_list)
        L = L * inv(L_list[i])       # L = I * L1^-1 * L2^-1 * ...
    end

    return U,L
end




function Diskreditierung_B(n)

    f(x, y) = 2*pi^2 * sin(pi*x) * sin(pi*y)

    h = 1/(n+1)
    b = zeros(n^2)

    for j in 1:n-1
        for i in 1:n

            xi = i*h
            yi = j*h
            
            k = j*n + i

            b[k] = f(xi, yi)
        end
    end
    return b
end





for n in [5, 10, 15, 20, 25, 30, 50]

    U_D, L_D = LU_Zerlegung(D_matrix(n))


    u = inv(U_D)* inv(L_D) * Diskreditierung_B(n)


    println("n = ", n)
    println("u = ", u)
    println()
end
