extends State
class_name CameraState
"""
# file		camera_state.gd
# author	Devone Reynolds
# par		email: gamedevone1@gmail.com
# date		31 DEC 2020
# brief		Base type for the camera rig's state classes. Contains boilerplate 
			code to get autocompletion and type hints.
"""

# Gives access to the CameraRig Node for all Camera States
var camera_rig: CameraRig

"""
# brief		Called when the node is 'ready', i.e. when both the node and its 
			children have entered the scene tree.
"""
func _ready() -> void:
	# Wait for State Machine to be ready before initialiing variables
	yield(owner, "ready")
	camera_rig = owner
