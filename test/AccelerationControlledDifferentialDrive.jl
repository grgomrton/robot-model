using Base.Test
include("../model/AccelerationControlledDifferentialDrive.jl")

let state = initial_state(0.5, 1.2, π/4, 0.2, 0.4)
    ε = 0.0001
    x, y = view(state, 1:2)
    theta = view(state, 3)
    v_left, v_right = view(state, 4:5)
    @test [x, y] ≈ [0.5, 1.2]
    @test theta ≈ [0.78539] atol=ε
    @test [v_left, v_right] ≈ [0.2, 0.4]
    println("success init test")
end

#let state = initial_state(0, 0, 0, 0, 0)
#    cycle_time = 0.05
#    control = [1 1]
#    state = state_update(state, control, cycle_time)
#    @test state[1] > 0
#    @test view(state, 3) ≈ [0]
#    @test view(state, 4:5) ≈ [0.05, 0.05]
#
#    state = state_update(state, control, cycle_time)
#    @test view(state, 1:2) ≠ [0, 0]
#    @test view(state, 3) ≈ [0]
#    @test view(state, 4:5) ≈ [0.1, 0.1]
#    println("succes multiple cycle test")
#end

let state = initial_state(0, 0, 0, 0, 0)
    cycle_time = 2
    radius = 0.033
    acceleration = 10
    control = [acceleration acceleration]
    expected_position = 0.66
    ε = 0.001

    state = state_update(state, control, cycle_time)

    println(view(state, 1) - expected_position)
    @test view(state, 1) ≈ [expected_position] atol=ε
    println("succes continous acceleration test")
end

let state = initial_state(0, 0, 0, 0, 0)
    # using smaller acceleration does not
    # help me loosen the cycle time
    cycle_time = 0.002
    radius = 0.033
    acceleration = 5
    control = [acceleration acceleration]
    duration = √8
    cycle_count = duration / cycle_time
    expected_position = 0.66
    ε = 0.001

    for i = 1:cycle_count
        state = state_update(state, control, cycle_time)
    end

    #println(view(state, 1) - expected_position)
    @test view(state, 1) ≈ [expected_position] atol=ε
    println("success lower speed continous acceleration test")
end
