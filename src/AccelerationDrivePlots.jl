using Plots
plotlyjs()

f(x) = sin(x)
x = linspace(0, 2π, 100)
y = f.(x)

for i in 1:length(x)
	println(x[i], ": ", y[i])
end

plot(x, y, title="The sinus function", xlabel="x", ylabel="f(x)", label="sin(x)")
gui()
