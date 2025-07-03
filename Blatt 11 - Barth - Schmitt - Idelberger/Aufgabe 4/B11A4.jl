using LinearAlgebra


function Matrix_A(n, alpha)

    diagonale = fill(1+alpha, n)      
    nebendiagonale = fill(-1, n - 1)  

    return Tridiagonal(nebendiagonale, diagonale, nebendiagonale)
end


function Jacobi(A::AbstractMatrix, b::Vector, x0::Vector, N::Int)
    n = length(b)
    x_m = copy(x0)
    for k in 1:N
        for i in 1:n

            sum = 0
            for j in 1:n
                if j != i
                    sum += A[i,j]*x_m[i]
                end
            end

            x_m[i]=(b[i]-sum)/A[i,i]
        end
    end
    return x_m
end




function GaussSeidel(A::AbstractMatrix, b::Vector, x0::Vector, N::Int)
    n = length(b)
    x_k1 = copy(x0) #x_k+1

    for k in 1:N
        x_k = copy(x_k1)

        for i in 1:n

            sum1 = 0.0  
            for j in 1:i-1              # j < i
                sum1 += A[i, j] * x_k1[j]
            end

            sum2 = 0.0  
            for j in i+1:n                  #j > i
                sum2 += A[i, j] * x_k[j]
            end

            x_k1[i] = (b[i] - sum1 - sum2) / A[i, i]
        end
    end
    return x_k1
end


# Beispiel
n = 10
α = 1.0
A = Matrix_A(n, α)
x_star = ones(n)             # Wahre Lösung
b = A * x_star               # Rechte Seite

x0 = zeros(n)
x_J = Jacobi(A, b, x0, 10)
x_G = GaussSeidel(A, b, x0, 10)



# Fehler ausrechnen:
fehler1 = norm(x_J - x_star)
println("Fehler Jacobi: ", fehler1)

fehler2 = norm(x_G - x_star)
println("Fehler Gauß-Seidel: ", fehler2)