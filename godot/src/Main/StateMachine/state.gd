class_name State
extends Node
"""
# file		state.gd
# author	Devone Reynolds
# par		email: gamedevone1@gmail.com
# date		21 DEC 2020
# brief		State interface to use in Hierarchical State Machines. 
# note		The lowest leaf tries to handle callbacks, and if it can't, it 
			delegates the work to its parent. 
# note 		It's up to the user to call the parent state's functions, e.g. 
			`_parent.physics_process(delta)`. 
# note		Use State as a child of a StateMachine node.
"""


# Reference to state machine controlling all of the states
onready var _state_machine := _get_state_machine(self)

# Parent state that allows concurent state usages, i.e running and aiming
# Using the same class, i.e. State, as a type hint causes a memory leak in Godot
# 3.2.
var _parent = null


"""
# brief		Called when the node is 'ready', i.e. when both the node and its 
			children have entered the scene tree.
"""
func _ready() -> void:
	yield(owner, "ready")
	var parent = get_parent()
	if not parent.is_in_group("state_machine"):
		_parent = parent


"""
# brief			Called when an InputEvent hasn't been consumed by _input() or 
				any GUI.
# param event
				Input event that occured.
"""
func unhandled_input(event: InputEvent) -> void:
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
# brief			Called during the physics processing step of the main loop. 
				Physics processing means that the frame rate is synced to the 
				physics, i.e. the delta variable should be constant.
# param delta
				Amount of time that has passed since last call to 
				_physics_process.
"""
func physics_process(delta: float) -> void:
	pass


"""
# brief		Called when object is transitioned to this state.
# param msg	Additional varibales passed along to the requested state.
"""
func enter(msg := {}) -> void:
	pass


"""
# brief		Called as the object is transitioned out of this state.
"""
func exit() -> void:
	pass


"""
# brief			Setter for _state_machine variable.
# param node	Passes self to find correct parent
"""
func _get_state_machine(node: Node) -> Node:
	if node != null and not node.is_in_group("state_machine"):
		return _get_state_machine(node.get_parent())
	return node
