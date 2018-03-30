# differential drive model
L = 0.13    # m : distance between the wheels
r = 0.033   # m : wheel radius

function initial_state(x_world, y_world, theta_world, speed_left_wheel, speed_right_wheel)
    return [x_world y_world theta_world speed_left_wheel speed_right_wheel]
end

function velocities(robot_state, control)
    x, y, theta, speed_left_wheel, speed_right_wheel = robot_state
    dx = r/2 * (speed_left_wheel + speed_right_wheel) * cos(theta)
    dy = r/2 * (speed_left_wheel + speed_right_wheel) * sin(theta)
    dtheta = r/L * (speed_right_wheel - speed_left_wheel)

    acceleration_left_wheel, acceleration_right_wheel = control
    dspeed_left = acceleration_left_wheel
    dspeed_right = acceleration_right_wheel

    return [dx dy dtheta dspeed_left dspeed_right]
end

function state_update(robot_state, control, elapsed_time)
    return robot_state + elapsed_time * velocities(robot_state, control)
end
