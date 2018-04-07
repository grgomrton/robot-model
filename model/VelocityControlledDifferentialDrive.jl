L = 0.13    # m : distance between the wheels
r = 0.033   # m : wheel radius

function initial_state(x_world, y_world, theta_world)
    return [x_world y_world theta_world]
end

# updates the state by the specified control that was executed for
# the specified time. we will assume that the control was
# applied at the beginning of the time slot and
# it took effect immediately
function state_update(state, control, elapsed_time)
    x, y, theta = state
    dtheta = orientation_derivative(control)
    new_position = [x y] + elapsed_time * position_derivatives(theta + elapsed_time / 2 * dtheta, control)
    new_theta = theta + elapsed_time * dtheta
    return [new_position[1] new_position[2] new_theta]
end

function orientation_derivative(control)
    v_left_wheel, v_right_wheel = control
    return r/L * (v_right_wheel - v_left_wheel)
end

function position_derivatives(theta, control)
    v_left_wheel, v_right_wheel = control
    dx = r/2.0 * (v_left_wheel + v_right_wheel) * cos(theta)
    dy = r/2.0 * (v_left_wheel + v_right_wheel) * sin(theta)
    return [dx dy]
end
