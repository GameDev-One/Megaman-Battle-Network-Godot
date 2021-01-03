extends PlayerState
"""
# file		idle.gd
# author	Devone Reynolds
# par		email: gamedevone1@gmail.com
# date		31 DEC 2020
# brief		State for when there is no movement input.
# note		Supports triggering jump after the player started to fall.
"""


"""
# brief			Called when an InputEvent hasn't been consumed by _input() or 
				any GUI.
# param event
				Input event that occured.
"""
func unhandled_input(event: InputEvent) -> void:
	# Allow parent to handle input
	_parent.unhandled_input(event)


"""
# brief			Called during the physics processing step of the main loop. 
				Physics processing means that the frame rate is synced to the 
				physics, i.e. the delta variable should be constant.
# param delta
				Amount of time that has passed since last call to 
				_physics_process.
"""
func physics_process(delta: float) -> void:
	# Allow parent to process physics first
	_parent.physics_process(delta)
	
	# Transition to Run State if player has velocity
	if player.is_on_floor() and _parent.velocity.length() > 0.01:
		_state_machine.transition_to("Move/Run")
		
	# Transition to Air State if player is not on floor
	# This includes falling and jumping
	elif not player.is_on_floor():
		_state_machine.transition_to("Move/Air")


"""
# brief		Called when object is transitioned to this state.
# param msg	Additional varibales passed along to the requested state.
"""
func enter(msg: Dictionary = {}) -> void:
	# Ensure player has stopped moving
	_parent.velocity = Vector3.ZERO
	skin.transition_to(skin.States.IDLE)
	_parent.enter()


"""
# brief		Called as the object is transitioned out of this state.
"""
func exit() -> void:
	_parent.exit()
