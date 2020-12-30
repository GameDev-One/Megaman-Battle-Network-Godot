extends EggBotState
"""
# file		idle.gd
# author	Devone Reynolds
# par		email: gamedevone1@gmail.com
# date		27 DEC 2020
# brief		State for when the Egg Bot is talking with the player.
"""


"""
# brief			Called when an InputEvent hasn't been consumed by _input() or 
				any GUI.
# param event
				Input event that occured.
"""
func unhandled_input(event: InputEvent) -> void:
	# Move to the next dialogue passage if player interacts
	if event.is_action_pressed("interact") and not dialogue.can_branch:
		dialogue.advance()


"""
# brief		Called when object is transitioned to this state.
# param msg	Additional varibales passed along to the requested state.
"""
func enter(msg := {}) -> void:
	# Start talking to the player
	dialogue.advance()
	dialogue.show()
	Global.emit_signal("entered_dialogue")


"""
# brief		Called as the object is transitioned out of this state.
"""
func exit() -> void:
	# Restart the converstation from the beginning
	dialogue.change_passage(-1)
	dialogue.hide()
	Global.emit_signal("exited_dialogue")


"""
# brief		Transition back to idle state once last passage is reached.
"""
func _on_Dialogue_last_passage_reached() -> void:
	_state_machine.transition_to("Idle")
