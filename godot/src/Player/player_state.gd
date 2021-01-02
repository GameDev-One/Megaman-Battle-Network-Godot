extends State
class_name PlayerState
"""
# file		player_state.gd
# author	Devone Reynolds
# par		email: gamedevone1@gmail.com
# date		2 JAN 2021
# brief		Base type for the player's state classes. Contains boilerplate code 
			to get autocompletion and type hints.
"""


# Gives access to the Player Node for all Player States
var player: Player

# Gives access to the Mannequiny Node for all Player States
var skin: Mannequiny


"""
# brief		Called when the node is 'ready', i.e. when both the node and its 
			children have entered the scene tree.
"""
func _ready() -> void:
	# Wait for State Machine to be ready before initialiing variables
	yield(owner, "ready")
	player = owner
	skin = owner.skin
