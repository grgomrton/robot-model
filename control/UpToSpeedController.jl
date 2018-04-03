include("../model/AccelerationControlledDifferentialDrive.jl")

k_p = 4.0       # proportional constant
w_sweet = 6.81  # rad/sec : desired robot angular velocity

function get_control(robot_state)
    x, y, theta, v_left_wheel, v_right_wheel = robot_state
    return k_p * ([w_sweet w_sweet] - [v_left_wheel v_right_wheel])
end
