extends Node
"""
# file		game.gd
# author	Devone Reynolds
# par		email: gamedevone1@gmail.com
# date		20 DEC 2020
# brief		Controls overall parts of the game that do not belong to a specific
			Node such as screen resolution and inputs allowed from the player.
"""


"""
# brief		Called when the node is 'ready', i.e. when both the node and its 
			children have entered the scene tree.
"""
func _ready() -> void:
	# Connect to global signals
	var err_code = OK
	err_code = Global.connect("entered_dialogue", self, "disable_player_input")
	assert(!err_code, "Could not connect signal.")
	err_code = Global.connect("exited_dialogue", self, "enable_player_input")
	assert(!err_code, "Could not connect signal.")
	
	# Hide mouse at center of screen
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


"""
# brief			Called when there is an input event. The input event propagates 
				up through the node tree until a node consumes it.
# param event
				Input event that occured
"""
func _input(event: InputEvent) -> void:
	# Consume all mouse input events after children have had a chance to handle
	if event.is_action_pressed("click"):
		if Input.get_mouse_mode() != Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if event.is_action_pressed("toggle_mouse_captured"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		get_tree().set_input_as_handled()

	# Toggle between fullscreen and windowed mode
	if event.is_action_pressed("toggle_fullscreen"):
		OS.window_fullscreen = not OS.window_fullscreen
		get_tree().set_input_as_handled()


"""
# brief		Prevent the player from moving and using the camera controls
"""
func disable_player_input() -> void:
	$Player/StateMachine.transition_to("Talk")
	$Player/CameraRig/StateMachine.transition_to("Talk")


"""
# brief		Allow the player to move and use the camera controls
"""
func enable_player_input() -> void:
	$Player/StateMachine.transition_to("Move/Idle")
	$Player/CameraRig/StateMachine.transition_to("Camera/Default")

