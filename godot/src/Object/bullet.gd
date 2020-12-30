extends Spatial
"""
# file		bullet.gd
# author	Devone Reynolds
# par		email: gamedevone1@gmail.com
# date		29 DEC 2020
# brief		Basic bullet object that flies forward once spawned in the world.
"""


# Amount of damage done by the bullet
export(int, 0, 100) var damage = 1

# Speed at which the bullet flies through the air
export(int) var speed = 10

# Whether or not the bullet has been fired through the air
var is_shot = false


"""
# brief		Called when the node is 'ready', i.e. when both the node and its 
			children have entered the scene tree.
"""
func _ready() -> void:
	# Have the bullet act independent of its parent Node
	set_as_toplevel(true)


"""
# brief			Called during the physics processing step of the main loop. 
				Physics processing means that the frame rate is synced to the 
				physics, i.e. the delta variable should be constant.
# param delta
				Amount of time that has passed since last call to 
				_physics_process.
"""
func _physics_process(delta) -> void:
	# Move the bullet forward once it has been shot by an Object
	if is_shot:
		$RigidBody.apply_impulse(transform.basis.z, -transform.basis.z * speed)


"""
# brief			Deal damage and create an exploslion when bullet collides with
				an object.
# param body	Physics body that the bullet collided with
"""
func _on_Area_body_entered(body: Node) -> void:
	# Damage enemy and explode
	if body.is_in_group("Enemy"):
		body.health -= damage
	_create_explosion()


"""
# brief			Destroy the bullet after lifetime expires
"""
func _on_Lifetime_timeout():
	queue_free()


"""
# brief			Emit a particle explosion before destroying the bullet
"""
func _create_explosion():
	$Particles.emitting = true
	yield(get_tree().create_timer($Particles.lifetime), "timeout")
	queue_free()
