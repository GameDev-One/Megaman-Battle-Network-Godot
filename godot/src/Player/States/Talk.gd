extends PlayerState
# State for when talking to an NPC.
# No movement input is allowed.


# warning-ignore:unused_argument
func enter(msg: Dictionary = {}) -> void:
	skin.transition_to(skin.States.IDLE)


func exit() -> void:
	pass
