extends MetalBotState
"""
# file		idle.gd
# author	Devone Reynolds
# par		email: gamedevone1@gmail.com
# date		27 DEC 2020
# brief		State for when the Metal Bot has nothing do.
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
	if eyes.is_colliding():
		var object = eyes.get_collider()
		if object.is_in_group("Player"):
			_state_machine.transition_to("Alert", {object = object})


"""
# brief		Called when object is transitioned to this state.
# param msg	Additional varibales passed along to the requested state.
"""
func enter(msg := {}) -> void:
	# Play idle animation
	if not anim.is_playing():
		anim.play("idle")
		
	# Reset where to look
	eyes.rotation = Vector3.ZERO


"""
# brief		Called as the object is transitioned out of this state.
"""
func exit() -> void:
	# Stop playing any animation
	anim.stop(false)
