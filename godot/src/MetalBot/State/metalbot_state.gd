class_name MetalBotState
extends State
"""
# file		metalbot_state.gd
# author	Devone Reynolds
# par		email: gamedevone1@gmail.com
# date		27 DEC 2020
# brief		Base type for the MetalBot's state classes. 
# note		Contains boilerplate code to get autocompletion and type hints.
"""


# Reference to the entire MetalBot Node
var metalbot: MetalBot

# Gives access to the Head Node for all MetalBot States
var head: Spatial

# Gives access to the Eyes Node for all MetalBot States
var eyes: RayCast

# Gives access to the AnimationPlayer Node for all MetalBot States
var anim: AnimationPlayer


"""
# brief		Called when the node is 'ready', i.e. when both the node and its 
			children have entered the scene tree.
"""
func _ready() -> void:
	# Wait for State Machine to be ready before initialiing variables
	yield(owner, "ready")
	metalbot = owner
	head = owner.head
	eyes = owner.eyes
	anim = owner.anim
