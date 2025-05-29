#using Pkg; Pkg.instantiate(); Pkg.activate(@__DIR__); Pkg.add("Plots");
using Plots


function Trapez(a, b, N, phi0)

    #(a)
    h = (b-a)/N
    xk = [(a + k*h) for k in 0:N]  #xk hat N+1 Punkte, da man bei k =0 anfängt und bei k=N aufhört, sodass die randwerte a und b sind.
    
    #(b)
    k = sin(phi0/2)
    fxk = [(1/(1-k^2*sin(xi)^2)^(1/2)) for xi in xk]

    #Anwendung der Trapezformel
    sum = (fxk[1]+fxk[N+1])/2
    for i in 2:N
        sum += fxk[i]
    end 
    return sum * h
end



function Simpson(a, b, N, phi0)
    
    #(a)
    h = (b-a)/N
    xk = [(a + k*h) for k in 0:N]  #xk hat N+1 Punkte, da man bei k =0 anfängt und bei k=N aufhört, sodass die randwerte a und b sind.
    
    #(b)
    k = sin(phi0/2)
    fxk = [(1/(1-k^2*sin(xi)^2)^(1/2)) for xi in xk]

    #Anwendung der Simpsonregel
    sum = (fxk[1]+fxk[N+1])
    for i in 2:N
        z = (3+(-1)^i)  #i=2 dann z=4,i=3 dann z=2, dh.N muss gerade sein, damit das letzte i=4 
        sum += fxk[i]* z
    end 
    return sum * h/3
end






gitter = collect(range(0, 2*pi, 10))

y1 = [4*(1/9.81)^(1/2) * Trapez(0,pi/2, 20, phi) for phi in gitter]
y2 = [4*(1/9.81)^(1/2) * Simpson(0,pi/2, 20, phi) for phi in gitter]
y3 = fill(2, 10) 
plot(gitter, [y1, y2, y3], label=["T_Q Trapez" "T_Q Simpson" "T_L"], linewidth=[3 2 2], ls=:dot)
savefig(joinpath(@__DIR__, "result.png"))

println("Aus der Grafik Folgt, phi_0 ist nur zulässig für kleine Winkel bzw. für Winkel nahe 2pi (Kleinwinkel-Näherung bei Auslenkung in die andere Richtung.)")