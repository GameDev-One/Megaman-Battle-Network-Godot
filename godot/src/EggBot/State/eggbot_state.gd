extends State
class_name EggBotState
"""
# file		eggbot_state.gd
# author	Devone Reynolds
# par		email: gamedevone1@gmail.com
# date		26 DEC 2020
# brief		Base type for the EggBot's state classes. Contains boilerplate code 
			to get autocompletion and type hints.
"""


# Reference to the entire EggBot Node
var egg_bot: Spatial

# Gives access to the Animation Node for all EggBot States
var anim: AnimationPlayer

# Gives access to the Dialogue Node for all EggBot States
var dialogue: Node

# Gives access to the Interable Node for all EggBot States
var interact: Node


"""
# brief		Called when the node is 'ready', i.e. when both the node and its 
			children have entered the scene tree.
"""
func _ready() -> void:
	# Wait for State Machine to be ready before initialiing variables
	yield(owner, "ready")
	egg_bot = owner
	anim = owner.anim
	dialogue = owner.dialogue
	interact = owner.interact
