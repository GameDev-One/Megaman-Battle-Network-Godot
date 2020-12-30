extends MetalBotState
"""
# file		shoot.gd
# author	Devone Reynolds
# par		email: gamedevone1@gmail.com
# date		27 DEC 2020
# brief		State for when teh MetalBot is shooting at the target
"""


# Bullet object to be fired from the MetalBot
const Bullet = preload("res://assets/3d/Bullet/Bullet.tscn")


"""
# brief		Called when object is transitioned to this state.
# param msg	Additional varibales passed along to the requested state.
"""
func enter(msg := {}) -> void:
	# Wait before shooting the bullet
	$Cooldown.start()


"""
# brief		Shoot the bullet in the direction of the targer after waiting.
"""
func _on_Cooldown_timeout():
	var instance = Bullet.instance()
	instance.is_shot = true
	instance.scale = Vector3(3.0,3.0,3.0)
	instance.speed = 0.5
	eyes.add_child(instance)
	
	# Move back to an idle state after shooting
	_state_machine.transition_to("Idle")
