extends PlayerState
"""
# file		air.gd
# author	Devone Reynolds
# par		email: gamedevone1@gmail.com
# date		31 DEC 2020
# brief		State for when the player is jumping and falling.
"""


"""
# brief			Called during the physics processing step of the main loop. 
				Physics processing means that the frame rate is synced to the 
				physics, i.e. the delta variable should be constant.
# param delta
				Amount of time that has passed since last call to 
				_physics_process.
"""
func physics_process(delta: float) -> void:
	# Allow parent to handle physics first
	_parent.physics_process(delta)

	# Transition Idle state if on floor
	if player.is_on_floor():
		_state_machine.transition_to("Move/Idle")
		
	# Otherwise stop player from moving upwards indefinately
	elif player.is_on_ceiling():
		_parent.velocity.y = 0


"""
# brief		Called when object is transitioned to this state.
# param msg	Additional varibales passed along to the requested state.
"""
func enter(msg: Dictionary = {}) -> void:
	# Applay upward force to player
	match msg:
		{"velocity": var v, "jump_impulse": var ji}:
			_parent.velocity = v + Vector3(0, ji, 0)
	skin.transition_to(skin.States.AIR)
	_parent.enter()


"""
# brief		Called as the object is transitioned out of this state.
"""
func exit() -> void:
	_parent.exit()
