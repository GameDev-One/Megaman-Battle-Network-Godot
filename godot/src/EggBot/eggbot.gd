extends Spatial
"""
# file		eggbot.gd
# author	Devone Reynolds
# par		email: gamedevone1@gmail.com
# date		26 DEC 2020
# brief		Controls all actions for default Bot NPC
"""


# File path for any dialogue the player would have with this NPC
export(String, FILE, "*.json") var dialogue_file_name = ""

# Current index in the dialogue tree
var _current_dialogue_index = -1

# Gives access to the Dialogue Node in the State Machine 
onready var dialogue = $Dialogue

# Gives access to the Animation Node in the State Machine 
onready var anim = $AnimationPlayer

# Gives access to the Animation Node in the State Machine 
onready var interact = $Interactable


"""
# brief		Called when the node is 'ready', i.e. when both the node and its 
			children have entered the scene tree.
"""
func _ready() -> void:
	# Pass dialouge file to Dialogue Node before reading it in
	dialogue.file_name = dialogue_file_name
