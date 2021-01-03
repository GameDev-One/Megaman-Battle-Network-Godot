extends CanvasLayer
"""
# file		hud.gd
# author	Devone Reynolds
# par		email: gamedevone1@gmail.com
# date		31 DEC 2020
# brief		Heads up display for all interable objects in the world.
# note		Will display when the player aims at a target to display information
			about that object.
"""


# Reference to the information Label
onready var label = $Panel/VBoxContainer/HBoxContainer/Label

# Reference to the Object's HP as a ProgressBar
onready var hp_bar = $Panel/VBoxContainer/HBoxContainer2/ProgressBar

# Refernce to the Object's State
onready var state_label = $Panel/VBoxContainer/StateLabel/Label2


"""
# brief		Called when the node is 'ready', i.e. when both the node and its 
			children have entered the scene tree.
"""
func _ready():
	# Hide the HUD upon starting the game
	$Panel.hide()


"""
# brief		Once an object is found display information about it
"""
func _on_CameraRig_object_found(object):
	# Display information about the enemy if object exsits
	if object:
		if object.is_in_group("Enemy"):
			label.text = object.name
			hp_bar.max_value = object.max_health
			hp_bar.value = object.health
			hp_bar.get_node("Label").text = String(object.health)
			
			state_label.text = object.state_mach.state.name
		$Panel.show()
		
	# Otherwise keep the HUD hidden
	else:
		$Panel.hide()
