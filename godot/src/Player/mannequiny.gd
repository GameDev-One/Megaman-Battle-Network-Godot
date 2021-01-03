extends Spatial
class_name Mannequiny
"""
# file		mannequiny.gd
# author	Devone Reynolds
# par		email: gamedevone1@gmail.com
# date		1 JAN 2021
# brief		Controls the animation tree's transitions for this animated
			character.
# note		It has a signal connected to the player state machine, and uses the 
			resulting state names to translate them into the states for the 
			animation tree.
"""


# Possible Animation States
enum States { IDLE, RUN, AIR, LAND }

# Direction that the player is moving
var move_direction := Vector3.ZERO setget set_move_direction

# Whether or not the player has velcoity
var is_moving := false setget set_is_moving

# Reference to the AnimationTree
onready var animation_tree: AnimationTree = $AnimationTree

# Reference to the playback Node used to transition between animations
onready var _playback: AnimationNodeStateMachinePlayback = animation_tree["parameters/playback"]


"""
# brief		Called when the node is 'ready', i.e. when both the node and its 
			children have entered the scene tree.
"""
func _ready() -> void:
	animation_tree.active = true


"""
# brief				Set all animations to face the move direction
# param direction	
					Where each animation will face
"""
func set_move_direction(direction: Vector3) -> void:
	move_direction = direction
	animation_tree["parameters/move_ground/blend_position"] = direction.length()


"""
# brief				Let animation tree player know if the player is moving
# param value	
					True if moving otherwise false
"""
func set_is_moving(value: bool) -> void:
	is_moving = value
	animation_tree["parameters/conditions/is_moving"] = value


"""
# brief				Transition to the specificed animation
# param state_id	
					Specific animation state to transition to
"""
func transition_to(state_id: int) -> void:
	match state_id:
		States.IDLE:
			_playback.travel("idle")
		States.LAND:
			_playback.travel("land")
		States.RUN:
			_playback.travel("move_ground")
		States.AIR:
			_playback.travel("jump")
		_:
			_playback.travel("idle")
