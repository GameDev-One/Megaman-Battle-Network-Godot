tool
extends SpringArm
"""
# file		spring_arm.gd
# author	Devone Reynolds
# par		email: gamedevone1@gmail.com
# date		31 DEC 2020
# brief		Control the zoom of the camera with `zoom`, a value between 0 and 1.
"""


# Distance at which the arm is away from the camera
export var length_range := Vector2(3.0, 6.0) setget set_length_range

# Amount to zoom in/out by
export var zoom := 0.5 setget set_zoom

# Initial position of the camera rig before moving
onready var _position_start: Vector3 = translation


"""
# brief			Ensures that each value is greater than 0, and that 
				length_range.x <= length_range.y, then updates the zoom
# param value	Amount to set the range to as a Vector2
"""
func set_length_range(value: Vector2) -> void:
	# Ensure the range is above zero
	value.x = max(value.x, 0.0)
	value.y = max(value.y, 0.0)
	length_range.x = min(value.x, value.y)
	length_range.y = max(value.x, value.y)
	self.zoom = zoom

"""
# brief			Sets length for both the ray and the shape cast for zooming
# param value	Amount to set the zoom to as a float
"""
func set_zoom(value: float) -> void:
	assert(value >= 0.0 and value <= 1.0)
	zoom = value
	spring_length = lerp(length_range.y, length_range.x, zoom)
