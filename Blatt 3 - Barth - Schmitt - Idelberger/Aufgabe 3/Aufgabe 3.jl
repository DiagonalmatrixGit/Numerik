using Pkg
#Pkg.instantiate(); Pkg.activate(@__DIR__); Pkg.add("Plots"); 
using Plots


function Runge(x)
    return 1/(1+25*x^2)
end


function Lagrangepolyn(x, xlist, ylist)
    l = length(xlist)

    sum = 0.0

    for i in 1:l

        # li = Basispolynom
        li = 1.0
        for j in 1:l
            if i != j
                li *= (x-xlist[j])/(xlist[i]-xlist[j])
            end
        end

        sum += ylist[i]*li
    end

    return sum
end





function mitRunge(k, M)
    N = k*M

    x_global = collect(range(-1, 1, N))
    #für Fehlersuche:
    #println(x_global)
    y_global = Runge.(x_global)


    #Finale x und y koordinaten mit allen Subintervallen
    x_plot = Float64[]
    y_plot = Float64[]

    #erzeugt Subintervalle mit Schrittlänge M
    for p in 1:M:(N-M)
        #Subintervall x_p bis x_p+m
        x_sub = x_global[p:(p+ M)]
        #für Fehlersuche:
        #println(x_sub)
        y_sub = y_global[p:(p+M)]


        
        #erstellt ein Gitter mit 100 Punkten pro Subintervall
        x_subGitter = collect(range(x_sub[1], x_sub[end], 100))

        y_subGitter = [Lagrangepolyn(x, x_sub, y_sub) for x in x_subGitter]

        #fügt die Subintervalle zur Gesamtdarstellung hinzu
        append!(x_plot, x_subGitter)
        append!(y_plot, y_subGitter)
    end


    # Gitter für Originalfunktion
    x_runge = range(-1, 1, length=100)
    y_runge = Runge.(x_runge)

    plot(x_runge, y_runge, label="Rungefunktion", color=:blue)

    #ergänzt die interpolierte Lagrangefunktion
    plot!(x_plot, y_plot, ls=:dash, label="Lagangre", color=:red)

end


#Erklärungen siehe oben
function ohneRunge(k, M)
    N = k*M
    x_global = collect(range(-1, 1, N))
    y_global = Runge.(x_global)

    x_plot = Float64[]
    y_plot = Float64[]


    for p in 1:M:(N-M)
        x_sub = x_global[p:(p+M)]
        y_sub = y_global[p:(p+M)]


        x_subGitter = collect(range(x_sub[1], x_sub[end], 100))
        y_subGitter = [Lagrangepolyn(x, x_sub, y_sub) for x in x_subGitter]

        
        append!(x_plot, x_subGitter)
        append!(y_plot, y_subGitter)
    end


    plot(x_plot, y_plot, label="Interpolation")

end




#Test:

p1 = mitRunge(5, 4)
#savefig("/home/philippbarth/Numerik/Blatt 3 - Barth - Schmitt - Idelberger/Aufgabe 3/p1.png")

p2 = ohneRunge(5, 4)
#savefig("/home/philippbarth/Numerik/Blatt 3 - Barth - Schmitt - Idelberger/Aufgabe 3/p2.png")
