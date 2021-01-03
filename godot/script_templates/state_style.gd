class_name NewStateClass
extends State
"""
# file		state_style.gd
# author	Devone Reynolds
# par		email: gamedevone1@gmail.com
# date		3 JAN 2021
# copyright	Copyright (c) 2021 GameDevone
# brief		Contains boilerplate code and comments for creating new base state
			classes and follwing the coding style guide.
# note		This can be accessed when creating a new script and clicking the 
			templates option.
"""


"""
Variables should be written in this order. 

# Example on how onready variables should be formatted
onready var style_theme: Node = $StyleTheme
"""


"""
# brief		Called when the node is 'ready', i.e. when both the node and its 
			children have entered the scene tree.
"""
func _ready() -> void:
	# Wait for State Machine to be ready before initialiing variables
	yield(owner, "ready")
