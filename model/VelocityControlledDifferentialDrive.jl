L = 0.13    # m : distance between the wheels
r = 0.033   # m : wheel radius

# creates a new state based upon the previous one assuming that the
# specified control that was executed for the specified time.
# we will assume that the control was applied at the beginning of
# the time slot and it took effect immediately
function new_state(state, control, elapsed_time)
    x, y, θ = state
    ω_left, ω_right = control

    θ_midway = θ + 0.5 * elapsed_time * dθ(ω_left, ω_right)
    x_new = x + elapsed_time * dx(θ_midway, ω_left, ω_right)
    y_new = y + elapsed_time * dy(θ_midway, ω_left, ω_right)
    θ_new = θ + elapsed_time * dθ(ω_left, ω_right)

    return [x_new y_new θ_new]
end

# derivative of the x component of the state.
dx(θ, ω_left, ω_right) = r/2.0 * (ω_left + ω_right) * cos(θ)

# derivative of the y component of the state.
dy(θ, ω_left, ω_right) = r/2.0 * (ω_left + ω_right) * sin(θ)

# derivative of the orientation component of the state.
dθ(ω_left, ω_right) = r/L * (ω_right - ω_left)

# creates a new state given with the specified x, y and orientation
# components. the components should be in identical coordinate systems,
# e.g. world.
initial_state(x_world, y_world, θ_world) = [x_world y_world θ_world]
