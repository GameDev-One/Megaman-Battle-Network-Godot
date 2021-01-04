extends %BASE%
"""
# file		default_style.gd
# author	Devone Reynolds
# par		email: gamedevone1@gmail.com
# date		2 JAN 2021
# copyright	Copyright (c) 2021 GameDevone
# brief		Contains boilerplate code and comments for follwing the coding style
			guide.
# note		This can be accessed when creating a new script and clicking the 
			templates option.
"""


"""
Variables should be written in this order. 

# All should have a comment with the exception of signals.
signal on_default_style_selected

# Example on how enums should be formatted
enum Style { RED, BLUE, GREEN, YELLOW, }

# Example on how constants should be formatted
const MAX_STYLES = 200

# Example on how exports should be formatted
export(int) var style_code: int = 0

# Example on how public variables should be formatted
var style_points: int = 990

# Example on how private variables should be formatted
var _style_string: String = "Style Guide Rocks"

# Example on how onready variables should be formatted
onready var style_theme: Node = $StyleTheme
"""


"""
# brief		Called when the node is 'ready', i.e. when both the node and its 
			children have entered the scene tree.
"""
func _ready() -> void:
	pass


"""
# brief			Called during the processing step of the main loop. Processing 
				happens at every frame and as fast as possible, so the delta 
				time since the previous frame is not constant.
# param delta
				Amount of time that has passed since last call to _process.
"""
func process(delta: float) -> void:
	pass


"""
# brief			Called when an InputEvent hasn't been consumed by _input() or 
				any GUI.
# param event
				Input event that occured.
"""
func unhandled_input(event: InputEvent) -> void:
	pass
