include("../model/SensorModel.jl")
include("../model/VelocityControlledDifferentialDrive.jl")
using Base.Test

let robot_pose = initial_state(0, 0, 0) # X
    marker_position = [1.5 0]
    ε = 0.001

    sensed_position = detect_marker(robot_pose, marker_position)

    @test sensed_position[1] ≈ 0 atol=ε
    @test sensed_position[2] ≈ 1.5 atol=ε
end

let robot_pose = initial_state(0, 0, π/2) # B
    marker_position = [1.5 0]
    ε = 0.001

    sensed_position = detect_marker(robot_pose, marker_position)

    @test sensed_position[1] ≈ 1.5 atol = ε
    @test sensed_position[2] ≈ 0 atol = ε
end

let robot_pose = initial_state(-1, 0, 0)
    marker_position = [1.5 0]
    ε = 0.001

    sensed_position = detect_marker(robot_pose, marker_position)

    @test sensed_position[1] ≈ 0 atol=ε
    @test sensed_position[2] ≈ 2.5 atol=ε
end

let robot_pose = initial_state(0, -1, π/2) # C
    marker_position = [1.5 0]
    ε = 0.001

    sensed_position = detect_marker(robot_pose, marker_position)

    @test sensed_position[1] ≈ 1.5 atol=ε
    @test sensed_position[2] ≈ 1 atol=ε
end

let robot_pose = initial_state(-1, -1, 0) # D
    marker_position = [1.5 0]
    ε = 0.001

    sensed_position = detect_marker(robot_pose, marker_position)

    @test sensed_position[1] ≈ -1 atol=ε
    @test sensed_position[2] ≈ 2.5 atol=ε
end

let robot_pose = initial_state(1, 2, π/2) # F
    marker_position = [1.5 0]
    ε = 0.001

    sensed_position = detect_marker(robot_pose, marker_position)

    @test sensed_position[1] ≈ 0.5 atol=ε
    @test sensed_position[2] ≈ -2 atol=ε
end

let robot_pose = initial_state(-1, -0.5, π/2)
    marker_position = [1.5 0.5]
    ε = 0.001

    sensed_position = detect_marker(robot_pose, marker_position)

    @test sensed_position[1] ≈ 2.5 atol=ε
    @test sensed_position[2] ≈ 1 atol=ε
end

let robot_pose = initial_state(2, 1, π/2 + π/4)
    marker_position = [1 2]
    ε = 0.001

    sensed_position = detect_marker(robot_pose, marker_position)

    @test sensed_position[1] ≈ 0 atol=ε
    @test sensed_position[2] ≈ 1.414214 atol=ε
end
