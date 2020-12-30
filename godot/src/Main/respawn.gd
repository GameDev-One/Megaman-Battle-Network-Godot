extends Node
"""
# file		respawn.gd
# author	Devone Reynolds
# par		email: gamedevone1@gmail.com
# date		20 DEC 2020
# brief		Contains the logic for instant respawning by connecting the player
			and stage.
"""


# Relative path in the scene tree to the player
export(NodePath) var PlayerPath = NodePath()

# Relative path in the scene tree to the Stage
export(NodePath) var StagePath = NodePath()

# Reference to the Player
onready var Player = get_node(PlayerPath)

# Reference to the Stage
onready var Stage = get_node(StagePath)


"""
# brief		Locates and returns a valid respawn location for the player
# return	Nearest position where the player can respawn
"""
func find_nearest_respawn_point() -> Vector3:
	# Position of Player
	var PlayerPosition: Vector3 = Player.global_transform.origin

	# List of all platform locations
	var PlatformLocations: Array = Array()
	for cell in Stage.get_used_cells():
		PlatformLocations.append(Stage.map_to_world(cell.x,cell.y,cell.z))
		
	# Compare Player position to Platform Location
	var distance: float = 1000000.0
	var closest_location: Vector3 = Vector3()
	
	for location in PlatformLocations:
		var distance_apart = PlayerPosition.distance_to(location)
		
		# Store the closest platform location to the player
		if distance_apart < distance:
			distance = distance_apart
			closest_location = location
	
	# Return closest location
	return closest_location


"""
# brief		Respawn the player when they cross the Out of Bounds area 
"""
func _on_OutOfBounds_body_entered(body) -> void:
	# Respawn to nearest respawn point if is Player
	if body.is_in_group("Player"):
		Player.global_transform.origin = find_nearest_respawn_point()
