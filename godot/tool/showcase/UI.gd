extends Control

# A exported nodepath to the node that holds all of the
# surface tool example MeshInstance nodes.
export (NodePath) var path_to_examples;
# A variable to hold the node that holds all of the surface tool examples.
var examples_holder;

# A variable to hold the index of the current example in examples.
var current_example;
# A variable to hold the list of example MeshInstance nodes.
var example_nodes;


func _ready():
	# Get the examples holder and get the example nodes.
	examples_holder = get_node(path_to_examples);
	example_nodes = examples_holder.get_children();
	
	# Set the current example to the first example.
	current_example = 0;
	
	# For some reason, it seems even invisible nodes still cause shadows.
	# To get around this, we'll move all of the example nodes on the X axis
	# and make them invisible.
	for child_node in example_nodes:
		child_node.global_transform.origin.x = 10;
		child_node.visible = false;
	
	# Make the current example node visible and move it to the center of the scene.
	example_nodes[current_example].global_transform.origin.x = 0;
	example_nodes[current_example].visible = true;
	
	# Connect the 'pressed' signals in the buttons so the change_example function.
	# Pass in an additional argument so we know what to apply to current_example.
	get_node("Button_Next").connect("pressed", self, "change_example", [1]);
	get_node("Button_Previous").connect("pressed", self, "change_example", [-1]);


func change_example(direction):
	# Make the current example invisible, and move it away from the center of the scene.
	example_nodes[current_example].visible = false;
	example_nodes[current_example].global_transform.origin.x = 10;
	
	# Change current_example.
	current_example += direction;
	
	# If current_example is less than zero, then make it the maximum size in example_nodes
	# so it wraps around. Simiarlly, when current_example is more then the maximum size, turn it
	# to zero so it wraps around.
	if (current_example < 0):
		current_example = example_nodes.size()-1;
	elif (current_example > example_nodes.size()-1):
		current_example = 0;
	
	# Move the current example back to the center of the scene, and make it visible.
	example_nodes[current_example].global_transform.origin.x = 0;
	example_nodes[current_example].visible = true;
