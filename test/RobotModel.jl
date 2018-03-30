using Base.Test
include("../src/RobotModel.jl")

let state = initial_state(0, 0, 0, 0, 0)
    cycle_time = 0.05
    x, y = view(state, 1:2)
    @test [x, y] ≈ [0, 0]

    control = [1 1]
    state = state_update(state, control, cycle_time)
    # after first cycle the robot should not move, but acceleration should be considered
    @test view(state, 1:2) ≈ [0, 0]
    speed_left, speed_right = view(state, 4:5)
    @test [speed_left, speed_right] ≈ [0.05, 0.05]

    state = state_update(state, control, cycle_time)
    # after second cycle the robot should have moved
    @test view(state, 1:2) ≠ [0, 0]
    @test view(state, 4:5) ≈ [0.1, 0.1]

    print("success")
end
