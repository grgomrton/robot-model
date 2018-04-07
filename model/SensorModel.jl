# the sensor estimates the marker position relative to the robot base.
# we will assume to have a noiseless, perfect sensor.
function detect_marker(robot_pose, marker_position_world)
    x_robot, y_robot, theta_robot = robot_pose
    return hom2cart(rotate(-theta_robot + pi/2) * translate(-x_robot, -y_robot) * transpose(cart2hom(marker_position_world)))
end

cart2hom(coordinates) = [coordinates 1]

rotate(theta) = [cos(theta) -sin(theta) 0; sin(theta) cos(theta) 0; 0 0 1]

translate(dx, dy) = [1 0 dx; 0 1 dy; 0 0 1]

hom2cart(coordinates) = [coordinates[1]/coordinates[3] coordinates[2]/coordinates[3]]
