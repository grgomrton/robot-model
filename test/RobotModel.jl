using Base.Test

# ε = 0.001 # unused for now

let state = initial_state(0, 0, 0, 0, 0)
    x, y = view(state, 1:2)
    @test [x, y] ≈ [0, 0]

    control = [1 1]
    state = next_state(state, control)
    # after first cycle the robot should not move, but acceleration should be considered
    @test view(state, 1:2) ≈ [0, 0]
    left_speed, right_speed = view(state, 4:5)
    @test [left_speed, right_speed] ≈ [0.05, 0.05]

    state = next_state(state, control)
    # after second cycle the robot should have moved
    @test view(state, 1:2) ≠ [0, 0]
    @test view(state, 4:5) ≈ [0.1, 0.1]

    print("success")
end
