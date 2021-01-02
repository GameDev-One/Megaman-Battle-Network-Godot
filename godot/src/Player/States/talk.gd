extends PlayerState
"""
# file		talk.gd
# author	Devone Reynolds
# par		email: gamedevone1@gmail.com
# date		1 JAN 2021
# brief		State for when talking to an NPC.
# note		No movement input is allowed.
"""



"""
# brief		Called when object is transitioned to this state.
# param msg	Additional varibales passed along to the requested state.
"""
func enter(msg: Dictionary = {}) -> void:
	skin.transition_to(skin.States.IDLE)


"""
# brief		Called as the object is transitioned out of this state.
"""
func exit() -> void:
	pass
