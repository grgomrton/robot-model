using Base.Test
using Cubature
include("../model/AccelerationControlledDifferentialDrive.jl")

let state = initial_state(0, 0, 0, 0, 0)
    control = [10, 10]
    elapsed_time = 2
    (x0, y0, theta0, wl0, wr0) = state
    (al, ar) = control
    r = 0.033
    L = 0.13
    ε_integration = 0.000001
    expected_position_x = x0 + hquadrature(t -> r/2 * (wl0 + al*t + wr0 + ar*t) * cos(theta0 + r/L*(wr0-wl0)*t + r/L*(ar-al)*t^2/2), 0, elapsed_time; abstol=ε_integration)[1]
    expected_position_y = y0 + hquadrature(t -> r/2 * (wl0 + al*t + wr0 + ar*t) * sin(theta0 + r/L*(wr0-wl0)*t + r/L*(ar-al)*t^2/2), 0, elapsed_time; abstol=ε_integration)[1]
    expected_orientation = theta0 + r/L*(wr0-wl0)*elapsed_time + r/L*(ar-al)*elapsed_time^2/2
    ε_position = 0.001
	ε_orientation = 0.01

    state = new_state(state, control, elapsed_time)

    println()
	println("Constant acceleration linear move results")
    println("State:      ", state)
	println("Expected:   ", [expected_position_x expected_position_y expected_orientation])
	println("Error[mm]:  ", sqrt((expected_position_x - state[1])^2 + (expected_position_y - state[2])^2) * 1000)
	@test state[1] ≈ expected_position_x atol=ε_position
	@test state[2] ≈ expected_position_y atol=ε_position
	@test state[3] ≈ expected_orientation atol=ε_orientation
    println("Constant acceleration linear move pass")
end

let state = initial_state(1, 1.5, π/2, 5, 5)
    control = [-10, 0]
    elapsed_time = 0.1
    (x0, y0, theta0, wl0, wr0) = state
    (al, ar) = control
    r = 0.033
    L = 0.13
    ε_integration = 0.000001
    expected_position_x = x0 + hquadrature(t -> r/2 * (wl0 + al*t + wr0 + ar*t) * cos(theta0 + r/L*(wr0-wl0)*t + r/L*(ar-al)*t^2/2), 0, elapsed_time; abstol=ε_integration)[1]
    expected_position_y = y0 + hquadrature(t -> r/2 * (wl0 + al*t + wr0 + ar*t) * sin(theta0 + r/L*(wr0-wl0)*t + r/L*(ar-al)*t^2/2), 0, elapsed_time; abstol=ε_integration)[1]
    expected_orientation = theta0 + r/L*(wr0-wl0)*elapsed_time + r/L*(ar-al)*elapsed_time^2/2
    ε_position = 0.001
	ε_orientation = 0.01

    state = new_state(state, control, elapsed_time)

    println()
	println("Turn left from constant linear move results")
    println("State:      ", state)
	println("Expected:   ", [expected_position_x expected_position_y expected_orientation])
	println("Error[mm]:  ", sqrt((expected_position_x - state[1])^2 + (expected_position_y - state[2])^2) * 1000)
	@test state[1] ≈ expected_position_x atol=ε_position
	@test state[2] ≈ expected_position_y atol=ε_position
	@test state[3] ≈ expected_orientation atol=ε_orientation
    println("Turn left from constant linear move pass")
end

let (x0, y0, theta0, wl0, wr0) = initial_state(0, 0, 0, 0, 0)
    (al, ar) = [10, 10]
    elapsed_time = 2
    r = 0.033
    L = 0.13
    expected_x = 0.66
    expected_y = 0
    expected_theta = 0
    ε_integration = 0.000001
    ε_position = 0.001
	ε_orientation = 0.01

    calculated_theta = theta0 + r/L*(wr0-wl0)*elapsed_time + r/L*(ar-al)*elapsed_time^2/2
    calculated_x = x0 + hquadrature(t -> r/2 * (wl0 + al*t + wr0 + ar*t) * cos(theta0 + r/L*(wr0-wl0)*t + r/L*(ar-al)*t^2/2), 0, elapsed_time; abstol=ε_integration)[1]
    calculated_y = y0 + hquadrature(t -> r/2 * (wl0 + al*t + wr0 + ar*t) * sin(theta0 + r/L*(wr0-wl0)*t + r/L*(ar-al)*t^2/2), 0, elapsed_time; abstol=ε_integration)[1]

    println()
    println("cubature test suit test constant acceleration linear move result")
    println("Calculated: ", [calculated_x calculated_y calculated_theta])
	println("Expected:   ", [expected_x expected_y expected_theta])
	println("Error[mm]:  ", sqrt((expected_x - calculated_x)^2 + (expected_y - calculated_y)^2) * 1000)
    @test calculated_x ≈ expected_x atol = ε_position
	@test calculated_y ≈ expected_y atol = ε_position
	@test calculated_theta ≈ expected_theta atol = ε_orientation
    println("cubature test suit test constant acceleration linear move pass")
end
