using Base.Test
include("../src/RobotModel.jl")

let state = initial_state(0, 0, 0, 0, 0)
    cycle_time = 0.05

    x, y = view(state, 1:2)
    theta = view(state, 3)
    v_left, v_right = view(state, 4:5)
    @test [x, y] ≈ [0, 0]
    @test theta ≈ [0]
    @test [v_left, v_right] ≈ [0, 0]

    control = [1 1]
    state = state_update(state, control, cycle_time)
    @test view(state, 1:2) ≈ [0, 0]
    @test view(state, 3) ≈ [0]
    @test view(state, 4:5) ≈ [0.05, 0.05]

    state = state_update(state, control, cycle_time)
    @test view(state, 1:2) ≠ [0, 0]
    @test view(state, 3) ≈ [0]
    @test view(state, 4:5) ≈ [0.1, 0.1]

    print("success")
end
