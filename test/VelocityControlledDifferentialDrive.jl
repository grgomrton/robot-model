using Base.Test
include("../model/VelocityControlledDifferentialDrive.jl")

let state = initial_state(0, 0, 0)
    # directly controlling velocity
    # command is assumed to take effect instantly
    cycle_time = 0.002
    radius = 0.033
    acceleration = 10
    duration = 2
    cycle_count = duration / cycle_time
    expected_position = 0.66
    ε = 0.001

    for cycle = 1:cycle_count
        commanded_velocity = acceleration * cycle * cycle_time
        control = [commanded_velocity commanded_velocity]
        state = state_update(state, control, cycle_time)
    end

    #println(view(state, 1) - expected_position)
    @test view(state, 1) ≈ [expected_position] atol=ε
    println("succes velocity controlled robot continous acceleration test")
end
