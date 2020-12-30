tool
extends Spatial
class_name CameraRig
# Accessor class that gives the nodes in the scene access the player or some
# frequently used nodes in the scene itself.

# warning-ignore:unused_signal
signal aim_fired(target_position)
# warning-ignore:unused_signal
signal object_found(object)

onready var camera: ClippedCamera = $ClippedCamera
onready var spring_arm: SpringArm = $SpringArm
onready var aim_ray: RayCast = $ClippedCamera/AimRay
onready var aim_target: TextureRect = $Recticle
onready var muzzle: Position3D = $ClippedCamera/AimRay/Muzzle

var player: KinematicBody

var zoom := 0.5 setget set_zoom

onready var _position_start: Vector3 = translation


func _ready() -> void:
	set_as_toplevel(true)
	yield(owner, "ready")
	player = owner


func _get_configuration_warning() -> String:
	return "Missing player node" if not player else ""


func set_zoom(value: float) -> void:
	zoom = clamp(value, 0.0, 1.0)
	if not spring_arm:
		yield(spring_arm, "ready")
	spring_arm.zoom = zoom
