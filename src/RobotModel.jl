# differential drive model
cycle_time = 0.05   # sec
L = 0.13    # m : distance between the wheels
r = 0.033   # m : wheel radius

function initial_state(x_world, y_world, theta_world, left_wheel_speed, right_wheel_speed)
    return [x_world y_world theta_world left_wheel_speed right_wheel_speed]
end

function calculate_dots(robotstate, control)
    x, y, theta, left_speed, right_speed = robotstate
    x_dot = r/2 * (left_speed + right_speed) * cos(theta)
    y_dot = r/2 * (left_speed + right_speed) * sin(theta)
    theta_dot = r/L * (right_speed - left_speed)
    left_acceleration, right_acceleration = control
    left_speed_dot = left_acceleration
    right_speed_dot = right_acceleration
    return [x_dot y_dot theta_dot left_speed_dot right_speed_dot]
end

function next_state(robotstate, control)
    dots = calculate_dots(robotstate, control)
    return robotstate + cycle_time * dots
end

print(next_state(initial_state(0, 0, 0, 0, 0), [1 1]))
