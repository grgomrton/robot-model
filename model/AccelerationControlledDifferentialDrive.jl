# This is an approximate model of an acceleration controlled differential drive.
# The angular velocity and the orientation is updated using their closed form
# expression, the position change along x and y axes are updated
# using numerical integration with a configurable absolute precision.
using Cubature

L = 0.13    # m : distance between the wheels
r = 0.033   # m : wheel radius
ε_integration = 0.0001     # m : the maximum error with which the position components are estimated in one update

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
    x⁺ = x + Δx(θ, ω_left, α_left, ω_right, α_right, elapsed_time)
    y⁺ = y + Δy(θ, ω_left, α_left, ω_right, α_right, elapsed_time)

    return [x⁺ y⁺ θ⁺ ω_left⁺ ω_right⁺]
end

# Change in the x position assuming constant angular velocities.
# Units: θ : rad; ω : rad/s; α : rad/s²; t : s
function Δx(θ_init, ω_left_init, α_left, ω_right_init, α_right, elapsed_time)
    return hquadrature(t -> r/2 * (ω_left_init + Δω(α_left, t) + ω_right_init + Δω(α_right, t)) * cos(θ_init + Δθ(ω_left_init, α_left, ω_right_init, α_right, t)), 0, elapsed_time; abstol=ε_integration)[1] # TODO cubature doesn't seem to care about abstol
end

# Change in the y position assuming constant angular velocities.
# Units: θ : rad; ω : rad/s; α : rad/s²; t : s
function Δy(θ_init, ω_left_init, α_left, ω_right_init, α_right, elapsed_time)
    return hquadrature(t -> r/2 * (ω_left_init + Δω(α_left, t) + ω_right_init + Δω(α_right, t)) * sin(θ_init + Δθ(ω_left_init, α_left, ω_right_init, α_right, t)), 0, elapsed_time; abstol=ε_integration)[1]
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
