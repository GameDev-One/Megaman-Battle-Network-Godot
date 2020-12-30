extends CameraState
"""
# file		aim.gd
# author	Devone Reynolds
# par		email: gamedevone1@gmail.com
# date		30 DEC 2020
# brief		Activates the aiming mode for the camera.
# note		Moves the camera to the character's shoulder, and narrows the 
			field of view.
# note 		Projects a target on the environment.
"""


# Default projectile that the player fires
const Bullet = preload("res://assets/3d/Bullet/Bullet.tscn")

# Reference to th Tween Node used to interpolate the camera
onready var tween := $Tween

# Default field of view for aiming
export var fov := 40.0

# Location of the camera inrelation to the Player
export var offset_camera := Vector3(0.75, -0.7, 0)

# How fast the cameera moves in response to controller input
export var sensitivity_gamepad: Vector2 = Vector2()


"""
# brief			Called when an InputEvent hasn't been consumed by _input() or 
				any GUI.
# param event
				Input event that occured.
"""
func unhandled_input(event: InputEvent) -> void:
	# Return to default camera if aim key is pressed
	if event.is_action_pressed("toggle_aim"):
		_state_machine.transition_to("Camera/Default")

	# Fire a bullet if player pressed fire key
	elif event.is_action_pressed("fire"):
		# Determine where the player is aiming in global coordinates
		var target_position: Vector3 = (
			camera_rig.aim_ray.get_collision_point()
			if camera_rig.aim_ray.is_colliding()
			else camera_rig.get_global_transform().origin
		)
		
		# Create new bullet to be fired
		var projectile = Bullet.instance()
		camera_rig.muzzle.add_child(projectile)
		projectile.is_shot = true
			
		camera_rig.emit_signal("aim_fired", target_position)
	
	# Otherwise pass input event to parent
	else:
		_parent.unhandled_input(event)


"""
# brief			Called during the processing step of the main loop. Processing 
				happens at every frame and as fast as possible, so the delta 
				time since the previous frame is not constant.
# param delta
				Amount of time that has passed since last call to _process.
"""
func process(delta: float) -> void:
	_parent.process(delta)


"""
# brief		Called when object is transitioned to this state.
# param msg	Additional varibales passed along to the requested state.
"""
func enter(msg: Dictionary = {}) -> void:
	# Reveal aiming recticle 
	_parent._is_aiming = true
	camera_rig.aim_target.visible = true

	# Move camera into aiming position by interpolation
	camera_rig.spring_arm.translation = camera_rig._position_start + offset_camera
	_parent.sensitivity_gamepad = sensitivity_gamepad
	tween.interpolate_property(
		camera_rig.camera, 'fov', camera_rig.camera.fov, fov, 0.5, Tween.TRANS_QUAD, Tween.EASE_OUT
	)
	tween.start()


"""
# brief		Called as the object is transitioned out of this state.
"""
func exit() -> void:
	# Hide camera recticle
	_parent._is_aiming = false
	camera_rig.aim_target.visible = false

	# Move camera into default position by interpolation
	camera_rig.spring_arm.translation = camera_rig.spring_arm._position_start
	tween.interpolate_property(
		camera_rig.camera,
		'fov',
		camera_rig.camera.fov,
		_parent.fov_default,
		0.5,
		Tween.TRANS_QUAD,
		Tween.EASE_OUT
	)
	tween.start()
