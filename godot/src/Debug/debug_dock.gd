extends MarginContainer
"""
# file		debug_dock.gd
# author	Devone Reynolds
# par		email: gamedevone1@gmail.com
# date		27 DEC 2020
# brief		Contains UI widgets that display debug info about the game world.
"""


"""
# brief		Called when the node is 'ready', i.e. when both the node and its 
			children have entered the scene tree.
"""
func _ready() -> void:
	# Hide debug panel when game starts
	visible = false


"""
# brief			Called when there is an input event. The input event propagates 
				up through the node tree until a node consumes it.
# param event
				Input event that occured
"""
func _input(event: InputEvent) -> void:
	# Toggle debug panel if TAB is pressed
	if event.is_action_pressed('toggle_debug_menu'):
		visible = not visible
		accept_event()
