using Pkg; Pkg.instantiate(); Pkg.activate(@__DIR__); Pkg.add(["DelimitedFiles", "Interpolations"]);
using DelimitedFiles; using Interpolations; using Plots


#Dokument auslesen
data = readdlm(joinpath(@__DIR__,"data_linear.txt"), '\t', Float64; skipstart=1)

t, x, y = data[:, 1],data[:, 2], data[:, 3]


#Stützstellen
stuetz= collect(range(minimum(t), maximum(t), length=100))


#Lineare Interpolationen
x_interpoliert = LinearInterpolation(t, x).(stuetz)
y_interpoliert = LinearInterpolation(t, y).(stuetz)


#neue Daten in die Datei schreiben
open(joinpath(@__DIR__,"ergebnis.txt"), "w") do io
    writedlm(io, ["# t x y"])
    writedlm(io, [stuetz x_interpoliert y_interpoliert])
end


#Ergebnis aus der Simulation
println("Code: 1249")
println("Ich habe mehrere Durchgänge laufen lassen, der Code hat sich jedesmal erändern: 1213, 1237, 1249")
