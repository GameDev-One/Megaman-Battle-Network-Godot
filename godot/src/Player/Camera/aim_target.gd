extends Sprite3D
"""
# file		state.gd
# author	Devone Reynolds
# par		email: gamedevone1@gmail.com
# date		21 DEC 2020
# brief		Visual target shape that gets projected on the environment, to 
			help the player aim.
"""

"""
# brief		Called when the node is 'ready', i.e. when both the node and its 
			children have entered the scene tree.
"""
func _ready() -> void:
	# Set independant from parent
	set_as_toplevel(true)


"""
# brief		Updates the postiion of the recticle once the camera moves
# param ray	RayCast that the recticle is attached to
"""
func update(ray: RayCast) -> void:
	# Make the reticle visible
	ray.force_raycast_update()
	var is_colliding := ray.is_colliding()
	visible = true
	
	# Update the position of the reticle based on where the RayCast is pointing
	if is_colliding:
		var collision_point := ray.get_collision_point()
		var collision_normal := ray.get_collision_normal()
		global_transform.origin = collision_point + collision_normal * 0.01
		look_at(collision_point - collision_normal, global_transform.basis.y.normalized())
