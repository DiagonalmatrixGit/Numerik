#using Pkg; Pkg.instantiate(); Pkg.activate(@__DIR__); Pkg.add(["DelimitedFiles", "BasicInterpolators"]);
using DelimitedFiles; using BasicInterpolators


#Dokument auslesen
data = readdlm(joinpath(@__DIR__,"data_cubic_clamped.txt"), '\t', Float64; skipstart=1)

t, x, y = data[:, 1],data[:, 2], data[:, 3]


#Stützstellen
stuetz= collect(range(minimum(t), maximum(t), length=100))


#Kubische Interpolation (0,0) = Werte der Ableitungen an den Rändern

x_interpoliert = CubicSplineInterpolator(t, x, 0,0).(stuetz)
y_interpoliert = CubicSplineInterpolator(t, y, 0,0).(stuetz)


#neue Daten in die Datei schreiben
open(joinpath(@__DIR__,"ergebnis.txt"), "w") do io
    writedlm(io, ["# t x y"])
    writedlm(io, [stuetz x_interpoliert y_interpoliert])
end

#Ergebnis aus der Simulation
println("Code: 1229")

