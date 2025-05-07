using Pkg
Pkg.add("Plots")
#Pkg.instantiate(); Pkg.add("Plots"); Pkg.activate("")
using Plots


function Runge(x)
    return 1/(1+25*x^2)
end



function interpolation(k::Int,M::Int)   #N ist das kfache der Natürlichen Zahl M
    N = k * M
    x = collect(range(-1, 1, N))
    y = Runge.(x)

end




function Lagrangepolyn(x, xlist, ylist)
    l = length(xlist)

    sum = 0.0

    for i in 1:n

        # li = Basispolynom
        li = 1.0
        for j in 1:n
            if i != j
                li *= (x-xlist[j])/(xlist[i]-xlist[j])
            end
        end

        sum += ylist[i]*li
    end

    return sum
end

