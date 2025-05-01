using LinearAlgebra

#Aufgabe 3 i)

#Vandermondematrix
function VMatrix(x::Vector)
    n = length(x)
    V = zeros(n,n)                         #Startmatrix aus Nullen
    for i in 1:n, j in 1:n
        V[i,j] = x[i]^(j-1)      
    end
    return V
end


#Determinante
function VDet(x::Vector)
    n = length(x)
    prod = 1                                #Produkt
    for i in 1:n, j in (i+1):n
        prod = prod * (x[j]-x[i])           #Index eines Vektors in Julia beginnt bei 1 nicht bei 0 
    end
    result = prod
end

#Aufgabe 3 ii)

function Gitter(N::Int)
    return collect(range(0, 10, N))         #collect erzuegt ein Array mit allen äquidistanten Punkten
end



#Aufgabe 3 iii)

for i in 2:10

    test=Gitter(i)
    println("Test-Vektor: ", test)
    println("Vandermondematrix: ", VMatrix(test))
    println("Vandermonde-Determinante: ", VDet(test))
    println("Determinate verifizieren: ", det(VMatrix(test)))
    println("Fehler: ", abs(det(VMatrix(test))-VDet(test)))
    println(" ")

end