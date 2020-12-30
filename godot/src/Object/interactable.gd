extends Node
"""
# file		interactable.gd
# author	Devone Reynolds
# par		email: gamedevone1@gmail.com
# date		29 DEC 2020
# brief		Node used to make objects in the world interactable. Indicates this 
			by creating an outline of the object.
# note		Every interable object will display an outline once the player is 
			close enough to interact with it.
# note		Each interable will need a mesh as the outline and an Area Node to 
			define the range at which the outline will show.
# note		Each object can define how it wants to handle player interactions by
			connecting to the 'player_interacted' signal
"""


signal player_interacted

# Outline mesh used to indicate the object can be interacted with
export(NodePath) var MeshOutlinePath = null

# Area Node used to determine when to turn on and off the outline
export(NodePath) var AreaOfInfluencePath = null

# Check if object does nothing but player can still interact with it
export(bool) var disabled = false

# Boolean to detect when player can interact with object
var canInteract = false

# Refernce to the outline mesh
onready var MeshOutline = get_node(MeshOutlinePath)

# Reference to the Area Node for the outline trigger
onready var AreaOfInfluence = get_node(AreaOfInfluencePath)


"""
# brief		Called when the node is 'ready', i.e. when both the node and its 
			children have entered the scene tree.
"""
func _ready():
	# Make sure outline is not visible to start
	if MeshOutline:
		MeshOutline.visible = false
	$Panel.hide()
	
	# Setup the interactions between Player and Interable objects
	make_interactable()
	
	$Panel/HBoxContainer/Label.text = get_parent().name


"""
# brief			Called when an InputEvent hasn't been consumed by _input() or 
				any GUI.
# param event
				Input event that occured.
"""
func _unhandled_input(event: InputEvent) -> void:
	# Let other objects know player has interacted with this object if enabled
	if canInteract and event.is_action_pressed("interact"):
		emit_signal("player_interacted")


"""
# brief		Setup the interactions between Player and Interable objects.
"""
func make_interactable():
	AreaOfInfluence.connect("body_entered", self, "on_body_entered")
	AreaOfInfluence.connect("body_exited", self, "on_body_exited")


"""
# brief		Show outline and name of object when player comes within range
"""
func on_body_entered(body:Node):
	# Show mesh outline if player is in range
	if body.is_in_group("Player"):
		if MeshOutline:
			MeshOutline.visible = true
		canInteract = true
		
		# Show name of object
		$Panel.show()


"""
# brief		Hide outline and name of object when player comes within range
"""
func on_body_exited(body:Node):
	# Hide mesh outline if player is out of range
	if body.is_in_group("Player"):
		if MeshOutline:
			MeshOutline.visible = false
		canInteract = false
		
		# Hide name of object
		$Panel.hide()
