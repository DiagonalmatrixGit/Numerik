#import Pkg;Pkg.activate("C:\\Users\\barth\\OneDrive\\Bilder\\Dokumente\\GitHub\\Numerik\\Blatt 2 - Barth - Schmitt - Idelberger\\Aufgabe 2");Pkg.instantiate(); Pkg.add("Plots")

using Plots


function fx(x::Float64)
    return exp(x)
end

function gx(x::Float64)
    return sin(pi*x)
end

function hx(x::Float64)
    return x - 0.5
end

function bernstein(f, n::Int, x::Float64)
    sum = 0.0
    for i in 0:n
        sum = sum + f(i/n)*binomial(n,i) *x^i * (1-x)^(n-i)
    end
    return sum
end



x = range(0,1, length=100 )

#Für f(x):
y1 = [bernstein(fx, 1, xi) for xi in x]
y2 = [bernstein(fx, 2, xi) for xi in x]
y3 = [bernstein(fx, 3, xi) for xi in x]
y4 = [bernstein(fx, 4, xi) for xi in x]
y5 = [bernstein(fx, 5, xi) for xi in x]


plot(x,[y1,y2,y3,y4,y5])
plot!(x,fx.(x),label="f(x)", ls=:dot)

#savefig("C:\\Users\\barth\\OneDrive\\Bilder\\Dokumente\\GitHub\\Numerik\\Blatt 2 - Barth - Schmitt - Idelberger\\Aufgabe 2\\fx.png")


#Für g(x):
y1 = [bernstein(gx, 1, xi) for xi in x]
y2 = [bernstein(gx, 2, xi) for xi in x]
y3 = [bernstein(gx, 3, xi) for xi in x]
y4 = [bernstein(gx, 4, xi) for xi in x]
y5 = [bernstein(gx, 5, xi) for xi in x]


plot(x,[y1,y2,y3,y4,y5])
plot!(x,gx.(x),label="g(x)", ls=:dot)

#savefig("C:\\Users\\barth\\OneDrive\\Bilder\\Dokumente\\GitHub\\Numerik\\Blatt 2 - Barth - Schmitt - Idelberger\\Aufgabe 2\\gx.png")


#Für g(x):
y1 = [bernstein(hx, 1, xi) for xi in x]
y2 = [bernstein(hx, 2, xi) for xi in x]
y3 = [bernstein(hx, 3, xi) for xi in x]
y4 = [bernstein(hx, 4, xi) for xi in x]
y5 = [bernstein(hx, 5, xi) for xi in x]


plot(x,[y1,y2,y3,y4,y5])
plot!(x,hx.(x),label="h(x)", ls=:dot)

#savefig("C:\\Users\\barth\\OneDrive\\Bilder\\Dokumente\\GitHub\\Numerik\\Blatt 2 - Barth - Schmitt - Idelberger\\Aufgabe 2\\hx.png")




