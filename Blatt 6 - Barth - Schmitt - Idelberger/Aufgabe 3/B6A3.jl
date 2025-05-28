#using Pkg; Pkg.instantiate(); Pkg.activate(@__DIR__); Pkg.add("TypedTables");
using TypedTables

function f(x::Float64)
    return exp(x)
end


function g(x::Float64)
    return abs(x)
end


function h(x::Float64)
    return cos(x)
end





function SimpsonQuad(f::Function, a::Float64, b::Float64, N::Float64)
    g = collect(range(a,b,N))
    sum = 0.0
    for i in 1:(N-1)
        a = g[i]
        b = g[i+1]

        sum += (b-a)/8 * (f(a)+3*f((2a+b)/3)+3*f((a+2b)/3)+f(b))
    end
    return sum
end


function BoolQuad(f::Function, a::Float64, b::Float64, N::Float64)
    g = collect(range(a,b,N))
    sum = 0.0
    for i in 1:(N-1)
        a = g[i]
        b = g[i+1]

        sum += (b-a)/90 * (7f(a)+32*f((3a+b)/4)+12*f((a+b)/2)+32*f((a+3b)/4)+7f(b))
    end
    return sum
end




#Test:


function Fehler(Int_f::Function,f::Function, N::Int64)
    g = collect(range(-1,1,N))
    sum = 0.0
    for i in 1:(N-1)
        sum += Int_f(f, g[i], g[i+1], N)
    end
    return abs(Int_f(f, -1.0, 1.0, N)-sum)
end


gitter = [5, 10 ,15, 20]
println(gitter)

f1 = [Fehler(SimpsonQuad, f, gi) for gi in gitter]
f2 = [Fehler(SimpsonQuad, g, gi) for gi in gitter]
f3 = [Fehler(SimpsonQuad, h, gi) for gi in gitter]
f4 = [Fehler(BoolQuad, f, gi) for gi in gitter]
f5 = [Fehler(BoolQuad, g, gi) for gi in gitter]
f6 = [Fehler(BoolQuad, h, gi) for gi in gitter]

t = Table(N = gitter, Fehler_Simpson_von_f = f1, Fehler_Bool_von_f = f4, Fehler_Simpson_von_g = f2, Fehler_Bool_von_g = f5, Fehler_Simpson_von_h = f3, Fehler_Bool_von_h = f6)
display(t)





