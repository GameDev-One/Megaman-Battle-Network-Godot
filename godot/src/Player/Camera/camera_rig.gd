tool
class_name CameraRig
extends Spatial
"""
# file		camera_rig.gd
# author	Devone Reynolds
# par		email: gamedevone1@gmail.com
# date		31 DEC 2020
# brief		Accessor class that gives the nodes in the scene access the player 
			or some frequently used nodes in the scene itself.
"""


signal aim_fired(target_position)

signal object_found(object)

# Player Node
var player: KinematicBody

# Distance at which to zoom the camera in
var zoom := 0.5 setget set_zoom

# Gives access to the Camera Node in the State Machine 
onready var camera: ClippedCamera = $ClippedCamera

# Gives access to the SpringArm Node in the State Machine 
onready var spring_arm: SpringArm = $SpringArm

# Gives access to the RayCast Node in the State Machine 
onready var aim_ray: RayCast = $ClippedCamera/AimRay

# Gives access to the AimTarget Node in the State Machine 
onready var aim_target: TextureRect = $Recticle

# Gives access to the Muzzle Node in the State Machine 
onready var muzzle: Position3D = $ClippedCamera/AimRay/Muzzle

# Initial position of camera before making movement calculations
onready var _position_start: Vector3 = translation


"""
# brief		Called when the node is 'ready', i.e. when both the node and its 
			children have entered the scene tree.
"""
func _ready() -> void:
	# Set independant from the parent Node and wait until owner is ready
	set_as_toplevel(true)
	yield(owner, "ready")
	player = owner

"""
# brief			Set zoom amount for Spring Arm
# param value	Amount to zoom in/out by
"""
func set_zoom(value: float) -> void:
	# Zoom value is between 0 and 1
	zoom = clamp(value, 0.0, 1.0)
	
	# Set zoom value on SpringArm
	if not spring_arm:
		yield(spring_arm, "ready")
	spring_arm.zoom = zoom
