class_name StateMachine
extends Node
"""
# file		state_machine.gd
# author	Devone Reynolds
# par		email: gamedevone1@gmail.com
# date		21 DEC 2020
# brief		Generic State Machine. Initializes states and delegates engine 
			callbacks. (_physics_process, _unhandled_input) to the active state.
"""


signal transitioned(state_path)

# State that the object will initialize with
export var initial_state := NodePath()

# Current state that the object is in
onready var state: State = get_node(initial_state) setget set_state

# Name of the current state
onready var _state_name := state.name


"""
# brief		Called when the State Machine is initialized.
"""
func _init() -> void:
	add_to_group("state_machine")


"""
# brief		Called when the node is 'ready', i.e. when both the node and its 
			children have entered the scene tree.
"""
func _ready() -> void:
	yield(owner, "ready")
	state.enter()


"""
# brief			Called when an InputEvent hasn't been consumed by _input() or 
				any GUI.
# param event
				Input event that occured.
"""
func _unhandled_input(event: InputEvent) -> void:
	# Pass down any unhandled input to the current state
	state.unhandled_input(event)


"""
# brief			Called during the processing step of the main loop. Processing 
				happens at every frame and as fast as possible, so the delta 
				time since the previous frame is not constant.

# param delta
				Amount of time that has passed since last call to _process.
"""
func _process(delta: float) -> void:
	# Pass down (dt) to the current state
	state.process(delta)


"""
# brief			Called during the physics processing step of the main loop. 
				Physics processing means that the frame rate is synced to the 
				physics, i.e. the delta variable should be constant.
# param delta
				Amount of time that has passed since last call to 
				_physics_process.
"""
func _physics_process(delta: float) -> void:
	# Pass down (dt) to the current state
	state.physics_process(delta)


"""
# brief						Change the current state to the requested state.
# param target_state_path
							Scene Tree path to the requested state.
# param msg
							Any varibales to be passed along to the requested 
							state.
"""
func transition_to(target_state_path: String, msg: Dictionary = {}) -> void:
	# Prevents tranisitioning to a state that does not exsist 
	if not has_node(target_state_path):
		return
	
	# Retrieve rerquested state
	var target_state := get_node(target_state_path)

	# Leave current state and enter requested state
	state.exit()
	self.state = target_state
	state.enter(msg)
	emit_signal("transitioned", target_state_path)


"""
# brief			Setter function for state variable
# param value
				State to change to.
"""
func set_state(value: State) -> void:
	state = value
	_state_name = state.name
