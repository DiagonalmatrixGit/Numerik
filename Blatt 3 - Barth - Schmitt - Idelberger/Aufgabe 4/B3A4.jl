using Pkg
#Pkg.instantiate(); Pkg.activate(@__DIR__); Pkg.add("Plots"); 
using Plots
Pkg.add("Interpolations")
using Interpolations





function Runge(x)
    return 1/(1+25*x^2)
end

function Diskr(N)
    return collect(range(-1, 1, N))
end







N=10


x = Diskr(N)
y = Runge.(x)


linear_spline = interpolate((x,), y, Gridded(Linear()))


x_mid = [(x[i] + x[i+1]) / 2 for i in 1:(N-1)]
y_mid_true = Runge.(x_mid)
y_mid_spline = linear_spline.(x_mid)


using Plots

plot(x, y, label="Runge-Funktion", lw=2)
scatter!(x_mid, y_mid_spline, label="Spline an Mittelpunkten", color=:red)
plot!(x_mid, y_mid_true, label="Wahre Werte an Mittelpunkten", linestyle=:dash)

# Fehleranalyse
errors = abs.(y_mid_true .- y_mid_spline)
println("Maximaler Fehler an Mittelpunkten: ", maximum(errors))

