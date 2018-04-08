# estimates the marker position relative to the robot base.
# we will assume to have a noiseless, perfect sensor.
function detect_marker(robot_pose_world, marker_position_world)
    return world2robot(marker_position_world, robot_pose_world)
end

# transforms the specified point in world coordinate system to robot coordinate system.
world2robot(point, robot_pose) = hom2cart(rotate(-robot_pose[3] + π/2) * translate(-robot_pose[1], -robot_pose[2]) * transpose(cart2hom(point)))

# converts to homogeneous coordinate system the specified cartesian
# point given in a row vector form.
cart2hom(coordinates) = [coordinates 1]

# converts to cartesian coordinates the specified homogeneous point
# given in either row or column vector form.
hom2cart(coordinates) = [coordinates[1]/coordinates[3] coordinates[2]/coordinates[3]]

# creates a rotation matrix for a 2d homogeneous coordinate point
# with the specified angle around the z axis in counter-clockwise direction.
rotate(θ) = [cos(θ) -sin(θ) 0; sin(θ) cos(θ) 0; 0 0 1]

# creates a translation matrix for a 2d homogeneous coordinate point
# with the specified translations along the x and y axes.
translate(dx, dy) = [1 0 dx; 0 1 dy; 0 0 1]
