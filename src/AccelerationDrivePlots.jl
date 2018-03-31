include("../src/AccelerationControlledDifferentialDrive.jl")
using Plots
plotlyjs()

let state = initial_state(0, 0, 0, 0, 0)
	cycle_time = 0.05
	acceleration = 10
	duration_acceleration = 0.5
	duration_constant_move = 1.0
	radius = 0.033
	states = zeros(0)
	timepoints = zeros(0)

	append!(timepoints, 0)
	append!(states, state)
	for timepoint in cycle_time:cycle_time:duration_acceleration
		control = [acceleration acceleration]
		state = state_update(state, control, cycle_time)
		append!(timepoints, timepoint)
		append!(states, state)
	end
	for timepoint in duration_acceleration+cycle_time:cycle_time:duration_acceleration+duration_constant_move
		control = [0 0]
		state = state_update(state, control, cycle_time)
		append!(timepoints, timepoint)
		append!(states, state)
	end

	states = reshape(states, 5, 31)
	plot(timepoints, view(states, 4, :), title="Angular velocity over time", xlabel="t [s]", ylabel="[rad/s]", label="v_joint", linewidth=2)
	plot(timepoints, view(states, 4, :) * radius, title="Robot velocity over time", xlabel="t [s]", ylabel="[m/s]", label="v_robot", linewidth=2)
	plot(timepoints, [view(states, 1, :), view(states, 2, :)], title="Robot position over time", xlabel="t [s]",  ylabel="[m]", label=["x" "y"], linewidth=2)
	gui()
end
