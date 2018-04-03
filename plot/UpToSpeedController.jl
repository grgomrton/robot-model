include("../model/AccelerationControlledDifferentialDrive.jl")
include("../control/UpToSpeedController.jl")

using Plots
plotlyjs()

let state = initial_state(0, 0, π/4, 0, 0)
	cycle_time = 0.05
	simulation_duration = 2
	radius = 0.033
	timepoints = zeros(0)
	states = zeros(0)
	controls = zeros(0)

	append!(timepoints, 0)
	append!(states, state)
	for timepoint in cycle_time:cycle_time:simulation_duration
		control = get_control(state)
		append!(controls, control)
		state = state_update(state, control, cycle_time)
		append!(timepoints, timepoint)
		append!(states, state)
	end
	append!(controls, [0 0])

	controls = reshape(controls, 2, 41)
	states = reshape(states, 5, 41)
	plot(timepoints, [view(controls, 1, :), view(controls, 2, :)], title="Angular acceleration commands", xlabel="t [s]", ylabel="[rad/s²]", label=["alpha_left_joint" "alpha_right_joint"], linewidth=2)
	#plot(timepoints, view(states, 4, :), title="Angular velocity over time", xlabel="t [s]", ylabel="[rad/s]", label="v_joint", linewidth=2)
	plot(timepoints, view(states, 4, :) * radius, title="Robot velocity over time", xlabel="t [s]", ylabel="[m/s]", label="v_robot", linewidth=2)
	#plot(timepoints, [view(states, 1, :), view(states, 2, :)], title="Robot position over time", xlabel="t [s]",  ylabel="[m]", label=["x" "y"], linewidth=2)
	gui()
end
