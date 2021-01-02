tool
class_name Player
extends KinematicBody
"""
# file		player.gd
# author	Devone Reynolds
# par		email: gamedevone1@gmail.com
# date		2 JAN 2021
# brief		Helper class for the Player scene's scripts to be able to have 
			access to the camera and its orientation.
"""


# Gives access to the CameraRig Node in the State Machine 
onready var camera: CameraRig = $CameraRig

# Gives access to the Mannequiny Node in the State Machine 
onready var skin: Mannequiny = $Mannequiny

# Gives access to the Mannequiny Node in the State Machine 
onready var state_machine: StateMachine = $StateMachine

