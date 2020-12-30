extends CameraState
"""
# file		state.gd
# author	Devone Reynolds
# par		email: gamedevone1@gmail.com
# date		21 DEC 2020
# brief		Parent state for all camera based states for the Camera. Handles 
			input based on the mouse or the gamepad. 
# note		The camera's movement depends on the active child state.
# note		Holds shared logic between all states that move or rotate the camera
"""


# Rate at which the camera can be zoomed in or out
const ZOOM_STEP: float = 0.1

# Minimum angle that the camera can rotate to in radians (-PI/4 = -180 degrees)
const ANGLE_X_MIN: float = -PI / 4

# Maximum angle that the camera can rotate to in radians (-PI/3 = 180 degrees)
const ANGLE_X_MAX: float = PI / 3

# Inverts the direction the camera moves up and down
export var is_y_inverted: bool = false

# Default field of view when not aiming down sights
export var fov_default: float = 70.0

# Amount of space kept between the player and the camera before rotating
export var deadzone := PI / 10

# How fast the cameera moves in response to controller input 
export var sensitivity_gamepad := Vector2(2.5, 2.5)

# How fast the cameera moves in response to mouse input
export var sensitivity_mouse := Vector2(0.1, 0.1)

# Relative length of input direction before being normalized for direction
var _input_relative := Vector2.ZERO

# Whether or not the camera is in the aim state
var _is_aiming := false


"""
# brief			Called during the processing step of the main loop. Processing 
				happens at every frame and as fast as possible, so the delta 
				time since the previous frame is not constant.
# param delta
				Amount of time that has passed since last call to _process.
"""
func process(delta: float) -> void:
	# Move the camera whenever the player moves
	camera_rig.global_transform.origin = (
		camera_rig.player.global_transform.origin
		+ camera_rig._position_start
	)

	# Rotate the camera based on either mouse or controller input
	var look_direction := get_look_direction()
	var move_direction := get_move_direction()

	# Mouse controls _input_relative
	if _input_relative.length() > 0:
		update_rotation(_input_relative * sensitivity_mouse * delta)
		_input_relative = Vector2.ZERO
			
	# Controller controls look_direction
	elif look_direction.length() > 0:
		update_rotation(look_direction * sensitivity_gamepad * delta)
		
	# Prevent from moving too close to the camera
	var is_moving_towards_camera: bool = (
		move_direction.x >= -deadzone
		and move_direction.x <= deadzone
	)
	if not (is_moving_towards_camera or _is_aiming):
		auto_rotate(move_direction)

	# Wrap around on the y-axis rotation
	camera_rig.rotation.y = wrapf(camera_rig.rotation.y, -PI, PI)
	
	
"""
# brief			Called during the physics processing step of the main loop. 
				Physics processing means that the frame rate is synced to the 
				physics, i.e. the delta variable should be constant.
# param delta
				Amount of time that has passed since last call to 
				_physics_process.
"""
func _physics_process(delta: float) -> void:
	# Check if player is looking at an object
	if camera_rig.aim_ray.is_colliding():
		camera_rig.emit_signal("object_found",camera_rig.aim_ray.get_collider())
	else:
		camera_rig.emit_signal("object_found", null)


"""
# brief					Rotate the camera by linear inperpolation
# param move_direction
						Direction to rotate the camera in
"""
func auto_rotate(move_direction: Vector3) -> void:
	# Find the target angle to move the camera in
	var offset: float = camera_rig.player.rotation.y - camera_rig.rotation.y
	var target_angle: float = (
		camera_rig.player.rotation.y - 2 * PI
		if offset > PI
		else camera_rig.player.rotation.y + 2 * PI if offset < -PI else camera_rig.player.rotation.y
	)
	
	# Smoothly rotate the camera by target angle
	camera_rig.rotation.y = lerp(camera_rig.rotation.y, target_angle, 0.015)


"""
# brief			Called when an InputEvent hasn't been consumed by _input() or 
				any GUI.
# param event
				Input event that occured.
"""
func unhandled_input(event: InputEvent) -> void:
	# Zoom in or out if action is pressed
	if event.is_action_pressed("zoom_in"):
		camera_rig.zoom += ZOOM_STEP
	elif event.is_action_pressed("zoom_out"):
		camera_rig.zoom -= ZOOM_STEP
		
	# Detect relative direction the mouse moves in
	elif event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		_input_relative += event.get_relative()


"""
# brief			Changes the rotation of the camera by an offset
# param offset
				How much the camera should rotate by as a Vector2
"""
func update_rotation(offset: Vector2) -> void:
	camera_rig.rotation.y -= offset.x
	camera_rig.rotation.x += offset.y * -1.0 if is_y_inverted else offset.y
	camera_rig.rotation.x = clamp(camera_rig.rotation.x, ANGLE_X_MIN, ANGLE_X_MAX)
	camera_rig.rotation.z = 0


"""
# brief		Returns the direction of the camera movement from the player
# note		Static functions do not get access to 'self'
"""
static func get_look_direction() -> Vector2:
	return Vector2(Input.get_action_strength("look_right") - Input.get_action_strength("look_left"), Input.get_action_strength("look_up") - Input.get_action_strength("look_down")).normalized()


"""
# brief		Returns the move direction of the character controlled by the player
# note		Static functions do not get access to 'self'
"""
static func get_move_direction() -> Vector3:
	return Vector3(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		0,
		Input.get_action_strength("move_back") - Input.get_action_strength("move_front")
	)
