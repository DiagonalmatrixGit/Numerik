using LinearAlgebra
#import Pkg;Pkg.activate("C:\\Users\\barth\\OneDrive\\Bilder\\Dokumente\\GitHub\\Numerik\\Blatt 2 - Barth - Schmitt - Idelberger\\Aufgabe 3");Pkg.instantiate(); Pkg.add("DataFrames")
using DataFrames  # Für die Tabelle
using Statistics  # für Zeit_Avg

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
tabelle = DataFrame(i=Int[], fehler=Float64[])


for i in 2:20

    test=Gitter(i)
#    println("Test-Vektor: ", test)
#    println("Vandermondematrix: ", VMatrix(test))
    detVana = VDet(test)
    detVnum = det(VMatrix(test))
    fehlerDet= abs(detVana - detVnum)
    println("Vandermonde-Determinante: ", detVana)
    println("Determinate verifizieren: ", detVnum)
    println(" ")
    push!(tabelle, (i=i, fehler = fehlerDet))

end

println(tabelle)

#AUfgabe 4
 function fx(x)
    return sin(exp(x))
 end


 tabelle2 = DataFrame(N=Int[], Durchnittliche_Zeit=Float64[], Konditionszahl=Float64[])

 for i in 2:10
    x = collect(Gitter(i))
    y = fx.(x)
    V = VMatrix(x)

#    println(y)
#    println(V)
    zeiten = Float64[]

    # Va=f nach a umgestellt mit Zeitrechnung
    for k in 1:10
        t = @elapsed begin
            a = V \ y
#            println(a)
#            println("")
        end
        push!(zeiten, t*1000)                   #Umrechnung in ms
    end    
    
    Zeit_Avg = mean(zeiten)                     # Bestimmt Durchnittliche Zeit für das Berechnen

    konditionszahl = opnorm(V,1) * opnorm(inv(V),1)

    push!(tabelle2, (N=i, Durchnittliche_Zeit=Zeit_Avg, Konditionszahl=konditionszahl))
end
println("")
println("Tabelle zu Aufgabe 3 (v)")
println(tabelle2)