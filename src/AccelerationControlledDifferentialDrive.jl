L = 0.13    # m : distance between the wheels
r = 0.033   # m : wheel radius
motor_controller_cycle_time = 0.002 # sec : the time between two consecutive updates of the motor speed

function execute(control, state, fortime)
    elapsed_time = 0
    while (elapsed_time < fortime)
        state = state + motor_controller_cycle_time * velocities(state, control)
        elapsed_time += motor_controller_cycle_time
    end
    return state
end

# updates the state by the specified control that was executed
# for the specified time. we will assume that the control
# was applied from the beginning of the time slot by the
# motor controller with the specified update interval
function state_update(state, control, elapsed_time)
    return execute(control, state, elapsed_time)
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

function initial_state(x_world, y_world, theta_world, v_left_wheel, v_right_wheel)
    return [x_world y_world theta_world v_left_wheel v_right_wheel]
end
