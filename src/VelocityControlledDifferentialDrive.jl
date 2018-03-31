L = 0.13    # m : distance between the wheels
r = 0.033   # m : wheel radius

function initial_state(x_world, y_world, theta_world)
    return [x_world y_world theta_world]
end

# updates the state by the specified control that was executed
# for the specified time. we will assume that the control
# was applied at the beginning of the time slot
# and the control took effect immediately
function state_update(state, control, elapsed_time)
    return state + elapsed_time * velocities(state, control)
end

function velocities(current_state, control)
    x, y, theta = current_state
    v_left_wheel, v_right_wheel = control
    dx = r/2 * (v_left_wheel + v_right_wheel) * cos(theta)
    dy = r/2 * (v_left_wheel + v_right_wheel) * sin(theta)
    dtheta = r/L * (v_right_wheel - v_left_wheel)

    return [dx dy dtheta]
end
