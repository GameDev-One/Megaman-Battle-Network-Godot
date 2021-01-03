extends PlayerState
"""
# file		run.gd
# author	Devone Reynolds
# par		email: gamedevone1@gmail.com
# date		1 JAN 21
# brief		Basic state when the player is moving around until jumping or lack 
			of input.
"""


"""
# brief			Called when an InputEvent hasn't been consumed by _input() or 
				any GUI.
# param event
				Input event that occured.
"""
func unhandled_input(event: InputEvent) -> void:
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
	# Allow parent to process input for moving before determining new state
	_parent.physics_process(delta)
	# Move to idle state if player's speed is close to 0
	if player.is_on_floor() or player.is_on_wall():
		if _parent.velocity.length() < 0.001:
			_state_machine.transition_to("Move/Idle")
	# Otherwise player is jumping
	else:
		_state_machine.transition_to("Move/Air")


"""
# brief		Called when object is transitioned to this state.
# param msg	Additional varibales passed along to the requested state.
"""
func enter(msg: = {}) -> void:
	# Transistion to running animation
	skin.transition_to(skin.States.RUN)
	skin.is_moving = true
	_parent.enter()


"""
# brief		Called as the object is transitioned out of this state.
"""
func exit() -> void:
	skin.is_moving = false
	_parent.exit()
