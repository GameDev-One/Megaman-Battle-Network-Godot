extends PlayerState
"""
# file		move.gd
# author	Devone Reynolds
# par		email: gamedevone1@gmail.com
# date		1 JAN 2021
# brief		Parent state for all movement-related states for the Player. Holds 
			all of the base movement logic.
# note		Child states can override this state's functions or change its
			properties. This keeps the logic grouped in one location.
"""


# How fast the player can potientally move
export var max_speed: = 12.0

# Intial speed speed player starts moving
export var move_speed: = 10.0

# Simiulated gravity value
export var gravity = -80.0

# Amount of force applied when player wants to jump
export var jump_impulse = 45

# Speed at which player rotates
export(float, 0.1, 20.0, 0.1) var rotation_speed_factor: = 10.0

# How fast the player is currently moving
var velocity: = Vector3.ZERO


"""
# brief			Called when an InputEvent hasn't been consumed by _input() or 
				any GUI.
# param event
				Input event that occured.
"""
func unhandled_input(event: InputEvent) -> void:
	# Transition to jump if jump button is pressed
	if event.is_action_pressed("jump"):
		_state_machine.transition_to("Move/Air", { velocity = velocity, jump_impulse = jump_impulse })


"""
# brief			Called during the physics processing step of the main loop. 
				Physics processing means that the frame rate is synced to the 
				physics, i.e. the delta variable should be constant.
# param delta
				Amount of time that has passed since last call to 
				_physics_process.
"""
func physics_process(delta: float) -> void:
	var input_direction: = get_input_direction()

	# Calculate a move direction vector relative to the camera
	# The basis stores the (right, up, -forwards) vectors of our camera.
	var forwards: Vector3 = player.camera.global_transform.basis.z * input_direction.z
	var right: Vector3 = player.camera.global_transform.basis.x * input_direction.x
	var move_direction: = forwards + right
	if move_direction.length() > 1.0:
		move_direction = move_direction.normalized()
	move_direction.y = 0
	skin.move_direction = move_direction

	# Rotation
	if move_direction:
		var target_direction: = player.transform.looking_at(player.global_transform.origin + move_direction, Vector3.UP)
		player.transform = player.transform.interpolate_with(target_direction, rotation_speed_factor * delta)

	# Movement
	velocity = calculate_velocity(velocity, move_direction, delta)
	velocity = player.move_and_slide(velocity, Vector3.UP)


"""
# brief		Returns the direction of the input for moving
# note		Static functions do not get access to 'self'
# return	Input Direction as a Vector3
"""
static func get_input_direction() -> Vector3:
	return Vector3(
			Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
			0,
			Input.get_action_strength("move_back") - Input.get_action_strength("move_front")
		)


"""
# brief						Returns the direction of the camera movement from 
							the player
# note						Static functions do not get access to 'self'
# param velocity_current	
							Current speed of the player
# param move_direction		
							Direction that the player is moving
# param delta				
							Time that has passed since the last call to 
							_process or _physics_process
# return					Estimated speed over delta time as a Vector 3
"""
func calculate_velocity(
		velocity_current: Vector3,
		move_direction: Vector3,
		delta: float
	) -> Vector3:
		# Calculate the new velocity and ensure it does not exceed max speed
		var velocity_new := move_direction * move_speed
		if velocity_new.length() > max_speed:
			velocity_new = velocity_new.normalized() * max_speed
		velocity_new.y = velocity_current.y + gravity * delta
		
		# Return newly calculated velocity
		return velocity_new
