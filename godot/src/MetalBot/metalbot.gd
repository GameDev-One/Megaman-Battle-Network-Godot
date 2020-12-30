class_name MetalBot
extends Enemy
"""
# file		metalbot.gd
# author	Devone Reynolds
# par		email: gamedevone1@gmail.com
# date		27 DEC 2020
# brief		A MetalBot enemy scans the area in a horizontal range looking for
			the player. Once found it will fire a direct shot in the player's
			direction. 
"""


# How far the MetalBot is scanning for the enemy.
export(int, 0, 100) var aggro_range = 15

# Whether or not MetalBot's HP is zero.
var _is_dead = false

# Gives access to the Head Node in the State Machine 
onready var head: Spatial = $Head

# Gives access to the RayCast Node in the State Machine 
onready var eyes: RayCast = $Head/RayCast

# Gives access to the AnimationPlayer Node in the State Machine 
onready var anim: AnimationPlayer = $AnimationPlayer

# Gives access to the StateMachine Node in the HUD
onready var state_mach: StateMachine = $StateMachine


"""
# brief		Called when the node is 'ready', i.e. when both the node and its 
			children have entered the scene tree.
"""
func _ready():
	# Initialize aggro detection range
	eyes.cast_to = Vector3(0,0,-aggro_range)


"""
# brief			Called during the processing step of the main loop. Processing 
				happens at every frame and as fast as possible, so the delta 
				time since the previous frame is not constant.

# param delta
				Amount of time that has passed since last call to _process.
"""
func _process(delta):
	# Play death animation once the MetalBot is dead
	if health <= 0 and not _is_dead:
		_is_dead = true
		$AnimationPlayer.play("death")
		$CollisionShape.disabled = true


"""
# brief		Once death animation is done emit some death particles and remove
			the MetalBot from the game
"""
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "death":
		$Base/Particles.emitting = true
		$Head/Particles.emitting = true
		$Head/CSGBox.hide()
		$Base/CSGCombiner.hide()
		yield(get_tree().create_timer($Head/Particles.lifetime),"timeout")
		queue_free()
