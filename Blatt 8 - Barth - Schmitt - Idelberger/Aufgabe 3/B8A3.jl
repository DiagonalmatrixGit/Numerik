using Pkg; Pkg.instantiate(); Pkg.activate(@__DIR__); Pkg.add(["TypedTables"]);
using TypedTables

function f(x)
    return x^3-2x+2
end


function f_abl(x)
    return 3x^2-2
end


function bisektion(f, a, b, tol)
    c = (a + b)/2
    y = f(c)

    if abs(f(c)) > tol

        if y == 0
            return c

        elseif y > 0
            bisektion(f,a,c,tol)

        else
            bisektion(f,c,b,tol)

        end
    
    else
        println("Keine Nullstelle gefunden")
        println("Näherungsweise x:", c)
        return c

    end
end




function newton(f, df, x0, n)
    x = x0

    for i in 1:n
        x_next = x - f(x)/df(x)
        x = x_next
    end

    return x
end





#Test (I):
tol = 4 * eps() 
bisektion(f, -2, -1, tol)



#Test (II):

n = 20

for x0 in [2,0,1,0.0835, 1.51] #Auswahl der Startwerte (Typed Tables ungeeignet, wegen restriktionen)

    println()
    println("Startwert: ", x0)

    for i in 1:n
    println(i, "    ", newton(f, f_abl, x0, i))
    end
end
