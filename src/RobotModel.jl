# differential drive

L = 0.13    # m : distance between the wheels
r = 0.033   # m : wheel radius

function initial_state(x_world, y_world, theta_world, v_left_wheel, v_right_wheel)
    return [x_world y_world theta_world v_left_wheel v_right_wheel]
end

function velocities(current_state, control)
    x, y, theta, v_left_wheel, v_right_wheel = current_state
    dx = r/2 * (v_left_wheel + v_right_wheel) * cos(theta)
    dy = r/2 * (v_left_wheel + v_right_wheel) * sin(theta)
    dtheta = r/L * (v_right_wheel - v_left_wheel)

    a_left_wheel, a_right_wheel = control
    dv_left = a_left_wheel
    dv_right = a_right_wheel

    return [dx dy dtheta dv_left dv_right]
end

function state_update(state, control, elapsed_time)
    return state + elapsed_time * velocities(state, control)
end
