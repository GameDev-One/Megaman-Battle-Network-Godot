extends CanvasLayer

onready var label = $Panel/VBoxContainer/HBoxContainer/Label
onready var hp_bar = $Panel/VBoxContainer/HBoxContainer2/ProgressBar
onready var state_label = $Panel/VBoxContainer/StateLabel/Label2

func _ready():
	$Panel.hide()

func _on_CameraRig_object_found(object):
	if object:
		if object.is_in_group("Enemy"):
			label.text = object.name
			hp_bar.max_value = object.max_health
			hp_bar.value = object.health
			hp_bar.get_node("Label").text = String(object.health)
			
			state_label.text = object.state_mach.state.name
		$Panel.show()
	else:
		$Panel.hide()
