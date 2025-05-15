using Pkg; Pkg.instantiate(); Pkg.activate(@__DIR__); Pkg.add("Plots"); 
using LinearAlgebra

function thomas_algorithm(l_eingabe, d_eingabe, u_eingabe, b_eingabe)
    n = length(d_eingabe)
    l = copy(l_eingabe)                 #copy-> ansonsten wird der originalarray ebenfalls verändert
    d = copy(d_eingabe) 
    u = copy(u_eingabe)               
    b = copy(b_eingabe)
    x = zeros(Float64, n)               # leeres x_n array

    u[1] /= d[1]
    b[1] /= d[1]

    for i in 2:n-1
        u[i] /= d[i] - l[i-1]*u[i-1]
        b[i] = (b[i] - l[i-1]*b[i-1]) / (d[i] - l[i-1] *u[i-1])
    end

    b[n] = (b[n] - l[n-1]*b[n-1]) / (d[n] - l[n-1]*u[n-1])
    x[n] = b[n]

    for i in n-1:-1:1                   # :-1: -> negative schritte, da die forschleife rekursiv läuft 
        x[i] = b[i] - u[i]* x[i+1]
    end

    return x
end


# Testdaten
n = 10
l = fill(-1.0, n-1)          # untere Diagonale
d = fill(2.0, n)             # Hauptdiagonale
u = fill(-1.0, n-1)          # obere Diagonale
x_exact = collect(1.0:n)     # wahre Lösung

# Tridiagonale Matrix explizit für Vergleich

A = Tridiagonal(l, d, u)
b = A * x_exact              # Rechte Seite berechnen

# Thomas-Algorithmus anwenden
x_thomas = thomas_algorithm(l, d, u, b)

# Vergleich mit Julia-Standardlösung
x_std = A \ b

println("Lösung Thomas: ", x_thomas)
println("Lösung Standard: ", x_std)
println("Fehler Thomas vs exakt: ", norm(x_thomas - x_exact))
println("Fehler Standard vs exakt: ", norm(x_std - x_exact))

