using Base.Test
include("../model/AccelerationControlledDifferentialDrive.jl")

let state_short_cycle = initial_state(0, 0, 0, 0, 0)
	state_long_cycle = initial_state(0, 0, 0, 0, 0)
	long_cycle = 0.1
	short_cycle = 0.05
	acceleration = 10

	control = [acceleration acceleration]
	println("long cycle update executing")
	state_long_cycle = state_update(state_long_cycle, control, long_cycle)
	println("short cycle update executing")
	state_short_cycle = state_update(state_short_cycle, control, short_cycle)
	state_short_cycle = state_update(state_short_cycle, control, short_cycle)

	println(state_short_cycle[1])
	println(state_long_cycle[1])
	@test state_short_cycle[1] ≈ state_long_cycle[1]
end
