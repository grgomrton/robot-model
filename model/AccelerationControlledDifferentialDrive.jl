# This is an approximate model of an acceleration controlled differential drive.
# The angular velocities and the orientation are updated using their closed form
# expression, the position along x and y axes are updated with the midway constant
# angular velocities. The error in this heuristic increases with time and
# with higher curvature.

L = 0.13    # m : distance between the wheels
r = 0.033   # m : wheel radius

# Creates a new state based upon the previous one assuming that the
# specified control that was executed continuously from the beginning
# of the time slot for the specified time.
# Units: x : m; y : m; θ : rad; ω : rad/s; α : rad/s²; t : s
function new_state(state, control, elapsed_time)
    x, y, θ, ω_left, ω_right = state
    α_left, α_right = control

    ω_left⁺ = ω_left + Δω(α_left, elapsed_time)
    ω_right⁺ = ω_right + Δω(α_right, elapsed_time)
    θ⁺ = θ + Δθ(ω_left, α_left, ω_right, α_right, elapsed_time)
    x⁺ = x + approximateΔx(θ, (ω_left + ω_left⁺)/2, (ω_right + ω_right⁺)/2, elapsed_time)
    y⁺ = y + approximateΔy(θ, (ω_left + ω_left⁺)/2, (ω_right + ω_right⁺)/2, elapsed_time)

    return [x⁺ y⁺ θ⁺ ω_left⁺ ω_right⁺]
end

# Change in the x position assuming constant angular velocities.
# Units: θ : rad; ω : rad/s; t : s
function approximateΔx(θ_init, ω_left, ω_right, elapsed_time)
    if ω_left != ω_right
        L/2.0 * (ω_left + ω_right)/(ω_right - ω_left) * (sin(θ_init + r/L * (ω_right - ω_left) * elapsed_time) - sin(θ_init))
    else
        r/2.0 * (ω_left + ω_right) * cos(θ_init) * elapsed_time
    end
end

# Change in the y position assuming constant angular velocities.
# Units: θ : rad; ω : rad/s; t : s
function approximateΔy(θ_init, ω_left, ω_right, elapsed_time)
    if ω_left != ω_right
        L/2.0 * (ω_left + ω_right)/(ω_right - ω_left) * (cos(θ_init) - cos(θ_init + r/L * (ω_right - ω_left) * elapsed_time))
    else
        r/2.0 * (ω_left + ω_right) * sin(θ_init) * elapsed_time
    end
end

# Change in the orientation after the specified time.
# Units: ω : rad/s; α : rad/s²; t : s
Δθ(ω_left_init, α_left, ω_right_init, α_right, elapsed_time) = r/L * (ω_right_init - ω_left_init) * elapsed_time + r/L * (α_right - α_left) * elapsed_time^2 / 2.0

# Change in the angular velocity over time.
# Units: α : rad/s²; t : s
Δω(α, elapsed_time) = α * elapsed_time

# Creates a new state given with the specified x, y and orientation
# components and the left and right wheel angular velocities.
# The position components should be in identical coordinate systems,
# e.g. world.
# Units: x : m; y : m; θ : rad; ω : rad/s
initial_state(x_world, y_world, θ_world, ω_left, ω_right) = [x_world y_world θ_world ω_left ω_right]
