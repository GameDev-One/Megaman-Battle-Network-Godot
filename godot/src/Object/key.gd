class_name Key
extends Spatial
"""
# file		key.gd
# author	Devone Reynolds
# par		email: gamedevone1@gmail.com
# date		23 DEC 2020
# brief		Object that unlocks a gate when the player collects it.
# note		Attach key to gate as a child to destory both when the key is 
			collected.
"""


signal key_collected

const AnimPlyr = preload("res://assets/3d/key/KeyAnimationPlayer.tscn")
var _animation_player

"""
# brief		Remove the key from the game when collected.
"""
func _ready() -> void:
	_animation_player = AnimPlyr.instance()
	add_child(_animation_player)
	_animation_player.play("idle")

func _on_Interactable_player_interacted():
	# Emit particles to signify collection
	$Particles.emitting = true
	_animation_player.play("fade_out")
	$MeshInstance/Outline.hide()
	
	# Wait for particles to disappear
	yield(get_tree().create_timer($Particles.lifetime), "timeout")
	emit_signal("key_collected")
