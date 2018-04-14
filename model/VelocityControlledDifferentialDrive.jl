# This is an exact model of a velocity controlled differential drive
# under the following assumptions:
# - the control was applied at the beginning of the time slot
# - the control took effect immediately
# - the wheels don't slip

L = 0.13    # m : distance between the wheels
r = 0.033   # m : wheel radius

# Creates a new state based upon the previous one assuming that the
# specified control that was executed for the specified time.
function new_state(state, control, elapsed_time)
    x, y, θ = state
    ω_left, ω_right = control

    θ⁺ = θ + Δθ(ω_left, ω_right, elapsed_time)
    x⁺ = x + Δx(ω_left, ω_right, θ, elapsed_time)
    y⁺ = y + Δy(ω_left, ω_right, θ, elapsed_time)

    return [x⁺ y⁺ θ⁺]
end

# Change in the x position assuming constant angular velocities.
function Δx(ω_left, ω_right, θ_init, elapsed_time)
    if ω_left != ω_right
        L/2.0 * (ω_left + ω_right)/(ω_right - ω_left) * (sin(θ_init + r/L * (ω_right - ω_left) * elapsed_time) - sin(θ_init))
    else
        r/2.0 * (ω_left + ω_right) * cos(θ_init) * elapsed_time
    end
end

# Change in the y position assuming constant angular velocities.
function Δy(ω_left, ω_right, θ_init, elapsed_time)
    if ω_left != ω_right
        L/2.0 * (ω_left + ω_right)/(ω_right - ω_left) * (cos(θ_init) - cos(θ_init + r/L * (ω_right - ω_left) * elapsed_time))
    else
        r/2.0 * (ω_left + ω_right) * sin(θ_init) * elapsed_time
    end
end

# Change in the orientation after the elapsed time.
Δθ(ω_left, ω_right, elapsed_time) = elapsed_time * r/L * (ω_right - ω_left)

# Creates a new state given with the specified x, y and orientation
# components. The components should be in identical coordinate systems,
# e.g. world.
initial_state(x_world, y_world, θ_world) = [x_world y_world θ_world]
