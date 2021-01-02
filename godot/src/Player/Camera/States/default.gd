extends CameraState
"""
# file		default.gd
# author	Devone Reynolds
# par		email: gamedevone1@gmail.com
# date		31 DEC 2020
# brief		Rotates the camera around the character, delegating all the work to 
			its parent state.
"""


"""
# brief			Called when an InputEvent hasn't been consumed by _input() or 
				any GUI.
# param event
				Input event that occured.
"""
func unhandled_input(event: InputEvent) -> void:
	# Toggle aim when toggle aim button is pressed
	if event.is_action_pressed("toggle_aim"):
		_state_machine.transition_to("Camera/Aim")
		
	# Otherwise pass event to parent
	else:
		_parent.unhandled_input(event)


"""
# brief		Called when object is transitioned to this state.
# param msg	Additional varibales passed along to the requested state.
"""
func enter(msg: Dictionary = {}) -> void:
	_parent.sensitivity_gamepad = Vector2(1.25,1.25)


"""
# brief			Called during the processing step of the main loop. Processing 
				happens at every frame and as fast as possible, so the delta 
				time since the previous frame is not constant.
# param delta
				Amount of time that has passed since last call to _process.
"""
func process(delta: float) -> void:
	_parent.process(delta)
