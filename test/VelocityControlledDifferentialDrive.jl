using Base.Test
include("../model/VelocityControlledDifferentialDrive.jl")

let state = initial_state(1, 0, π/2)
	cycle_time = 0.1
	angular_velocity = 5.0
	expected_position_x = 1.0
	expected_position_y = 0.0165
	ε_position = 0.001
	expected_orientation = 1.5707963
	ε_orientation = 0.01
	control = [angular_velocity angular_velocity]

	new_state = state_update(state, control, cycle_time)

	@test new_state[1] ≈ expected_position_x atol = ε_position
	@test new_state[2] ≈ expected_position_y atol = ε_position
	@test new_state[3] ≈ expected_orientation atol = ε_orientation
end

let state = initial_state(1, 0, π/2)
	cycle_time = 0.1
	angular_velocity = 5.0
	expected_position_y = 0.0165
	expected_position_x = 1.0
	ε_position = 0.001
	expected_orientation = 1.5707963
	ε_orientation = 0.01
	control = [angular_velocity angular_velocity]

	new_state = state_update(state, control, cycle_time)

	println()
	println("Constant linear move results")
	println(new_state)
	@test new_state[1] ≈ expected_position_x atol = ε_position
	@test new_state[2] ≈ expected_position_y atol = ε_position
	@test new_state[3] ≈ expected_orientation atol = ε_orientation
	println("Constant linear move pass")
end

let state = initial_state(1, 0, π/2)
	cycle_time = 0.1
	angular_velocity_left = 5.5
	angular_velocity_right = 6.5
	expected_position_x = 0.99974871
	expected_position_y = 0.0197979
	ε_position = 0.001
	expected_orientation = 1.596181
	ε_orientation = 0.01
	control = [angular_velocity_left angular_velocity_right]

	new_state = state_update(state, control, cycle_time)

	println()
	println("Constant circular move long cycle results")
	println("Expected:   ", [expected_position_x expected_position_y expected_orientation])
	println("Calculated: ", new_state)
	println("Error[mm]:  ", sqrt((expected_position_x - new_state[1])^2 + (expected_position_y - new_state[2])^2) * 1000)
	@test new_state[1] ≈ expected_position_x atol = ε_position
	@test new_state[2] ≈ expected_position_y atol = ε_position
	@test new_state[3] ≈ expected_orientation atol = ε_orientation
	println("Constant circular move long cycle pass")
end

let state = initial_state(1, 0, π/2)
	cycle_time = 0.1
	angular_velocity_left = 4.5
	angular_velocity_right = 6.5
	expected_position_x = 0.99953937
	expected_position_y = 0.0181422
	ε_position = 0.001
	expected_orientation = 1.621566
	ε_orientation = 0.01
	control = [angular_velocity_left angular_velocity_right]

	new_state = state_update(state, control, cycle_time)

	println()
	println("Constant circular move long cycle results")
	println("Expected:   ", [expected_position_x expected_position_y expected_orientation])
	println("Calculated: ", new_state)
	println("Error[mm]:  ", sqrt((expected_position_x - new_state[1])^2 + (expected_position_y - new_state[2])^2) * 1000)
	@test new_state[1] ≈ expected_position_x atol = ε_position
	@test new_state[2] ≈ expected_position_y atol = ε_position
	@test new_state[3] ≈ expected_orientation atol = ε_orientation
	println("Constant circular move long cycle high curvature pass")
end

let state = initial_state(1, 0, π/2)
	cycle_time = 0.1
	angular_velocity_left = 5.5
	angular_velocity_right = 6.5
	expected_position_x = 0.944136
	expected_position_y = 0.289875
	ε_position = 0.001
	expected_orientation = 1.95157
	ε_orientation = 0.01
	control = [angular_velocity_left angular_velocity_right]

	for i in 1:15
		state = state_update(state, control, cycle_time)
	end

	println()
	println("Constant circular move multiple update long cycle results")
	println("Expected:   ", [expected_position_x expected_position_y expected_orientation])
	println("Calculated: ", state)
	println("Error[mm]:  ", sqrt((expected_position_x - state[1])^2 + (expected_position_y - state[2])^2) * 1000)
	@test state[1] ≈ expected_position_x atol = ε_position
	@test state[2] ≈ expected_position_y atol = ε_position
	@test state[3] ≈ expected_orientation atol = ε_orientation
	println("Constant circular move multiple update long cycle pass")
end

let state = initial_state(1, 0, π/2)
	cycle_time = 0.05
	angular_velocity_left = 5.5
	angular_velocity_right = 6.5
	expected_position_x = 0.999937174
	expected_position_y = 0.00989973
	ε_position = 0.001
	expected_orientation = 1.583489
	ε_orientation = 0.01
	control = [angular_velocity_left angular_velocity_right]

	new_state = state_update(state, control, cycle_time)

	println()
	println("Constant circular move short cycle results")
	println("Expected:   ", [expected_position_x expected_position_y expected_orientation])
	println("Calculated: ", new_state)
	println("Error[mm]:  ", sqrt((expected_position_x - new_state[1])^2 + (expected_position_y - new_state[2])^2) * 1000)
	@test new_state[1] ≈ expected_position_x atol = ε_position
	@test new_state[2] ≈ expected_position_y atol = ε_position
	@test new_state[3] ≈ expected_orientation atol = ε_orientation
	println("Constant circular move short cycle pass")
end

let state = initial_state(1, 0, π/2)
	cycle_time = 0.05
	angular_velocity_left = 5.5
	angular_velocity_right = 6.5
	expected_position_x = 0.944136
	expected_position_y = 0.289875
	ε_position = 0.001
	expected_orientation = 1.95157
	ε_orientation = 0.01
	control = [angular_velocity_left angular_velocity_right]

	for i in 1:30
		state = state_update(state, control, cycle_time)
	end

	println()
	println("Constant circular move multiple update short cycle results")
	println("Expected:   ", [expected_position_x expected_position_y expected_orientation])
	println("Calculated: ", state)
	println("Error[mm]:  ", sqrt((expected_position_x - state[1])^2 + (expected_position_y - state[2])^2) * 1000)
	@test state[1] ≈ expected_position_x atol = ε_position
	@test state[2] ≈ expected_position_y atol = ε_position
	@test state[3] ≈ expected_orientation atol = ε_orientation
	println("Constant circular move multiple update short cycle pass")
end
