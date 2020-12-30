extends MetalBotState
"""
# file		alert.gd
# author	Devone Reynolds
# par		email: gamedevone1@gmail.com
# date		27 DEC 2020
# brief		State for when the MetalBot is determining what todo next after 
			finding the player.
"""


# How fast Metal Bots Turns towards the player
export(float, 0.1, 10.0) var turn_speed = 2

# What the MetalBot has its sights on
var _target: Spatial = null

# Whether or not the MetalBot's eyes are following the target
var _locked_on = false


"""
# brief			Called during the physics processing step of the main loop. 
				Physics processing means that the frame rate is synced to the 
				physics, i.e. the delta variable should be constant.
# param delta
				Amount of time that has passed since last call to 
				_physics_process.
"""
func physics_process(delta: float) -> void:
	# Rotate head towards target then shoot once target is found
	if eyes.is_colliding():
		if not _locked_on:
			eyes.look_at(_target.global_transform.origin, Vector3.UP)
			eyes.rotation.x = 0
			eyes.rotation.z = 0
			_locked_on = true
			head.rotate_y(deg2rad(eyes.rotation.y * turn_speed))
			
			# Pause before shooting
			yield(get_tree().create_timer(1.5),"timeout")
			_state_machine.transition_to("Shoot")
			
	# Otherwise go back to searching for enemy
	else:
		_state_machine.transition_to("Idle")


"""
# brief		Called when object is transitioned to this state.
# param msg	Additional varibales passed along to the requested state.
"""
func enter(msg := {}) -> void:
	# Initalize the target object that caused the alert
	if "object" in msg:
		_target = msg.object


"""
# brief		Called as the object is transitioned out of this state.
"""
func exit() -> void:
	# No longer locked on the target
	_locked_on = false
