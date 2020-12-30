extends EggBotState
"""
# file		idle.gd
# author	Devone Reynolds
# par		email: gamedevone1@gmail.com
# date		27 DEC 2020
# brief		State for when the Egg Bot has nothing do. Can transition over to 
			talking with the player once interacted with.
"""


"""
# brief			Called when an InputEvent hasn't been consumed by _input() or 
				any GUI.
# param event
				Input event that occured.
"""
func unhandled_input(event: InputEvent) -> void:
	# Change state to talk if player interactes with EggBot
	if event.is_action_pressed("interact") and interact.canInteract:
		_state_machine.transition_to("Talk")


"""
# brief		Called when object is transitioned to this state.
# param msg	Additional varibales passed along to the requested state.
"""
func enter(msg := {}) -> void:
	# Play Idle animation
	if not anim.is_playing():
		anim.play("idle")


"""
# brief		Called as the object is transitioned out of this state.
"""
func exit() -> void:
	# Stop playing any animations
	anim.stop(false)
