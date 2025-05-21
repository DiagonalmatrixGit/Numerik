#using Pkg; Pkg.instantiate(); Pkg.activate(@__DIR__); Pkg.add("Plots"); 
using Plots

function ht(t::Float64)
    return (pi-t)/2
end


function Fn(n::Int64,x::Float64)
    sum = 0.0
    for i in 1:n
        sum += sin(i*x)/i
    end
    return sum
end


x = range(0, 2*pi, length=100)
y0 = ht.(x)
y1 = Fn.(1,x)
y2 = Fn.(2,x)
y3 = Fn.(3,x)
y50 = Fn.(50,x)
plot(x, y0, label="h(t)", lw=2)
plot!(x, [y1,y2,y3,y50], label=["F1" "F2" "F3" "F50"] )
xlabel!("x")
ylabel!("y")

savefig(joinpath(@__DIR__, "Aufgabe 2.png"))