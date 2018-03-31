L = 0.13    # m : distance between the wheels
r = 0.033   # m : wheel radius
# this timing is nice and precise, it is questionable however
# whether my cheap kit will follow this accuracy.
# the pi's gpio can handle way higher frequencies than the one
# required to emit this one, it will depend on the h-bridge and
# on the motors' responsivenes. leave it as is for now.
motor_controller_cycle_time = 0.0125 # sec : the time between two consecutive updates of the motor velocity

# it is assumed that the motor controller can directly set
# the motor angular velocity and the control takes effect
# immediately
function execute(control, state, fortime)
    for cycle in motor_controller_cycle_time:motor_controller_cycle_time:fortime
        state = state + motor_controller_cycle_time * velocities(state, control)
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

# state derivatives
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
