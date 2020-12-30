extends Spatial
"""
# file		gate.gd
# author	Devone Reynolds
# par		email: gamedevone1@gmail.com
# date		23 DEC 2020
# brief		Object that blocks that player's movement until a key unlocks it.
# note		Attach key to gate as a child to destory both when the key is 
			collected.
"""


# Scene Tree path to the Key Object 
export(NodePath) var key_path = ""

# Key Object that will unlock the gate
onready var _key: Key = get_node(key_path)

"""
# brief		Called when the node is 'ready', i.e. when both the node and its 
			children have entered the scene tree.
"""
func _ready() -> void:
	# Connect key collection to gate
	var err_code = OK
	err_code = _key.connect("key_collected", self, "_on_key_collected")
	assert(!err_code, "Could not connect signal.")


"""
# brief		Remove the gate from the game when key is collected.
"""
func _on_key_collected():
	queue_free()
