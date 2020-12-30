extends MeshInstance

func _ready():
	
	# Make a new surface tool.
	var surface_tool = SurfaceTool.new();
	
	# Start the surface tool in primitive triangle mode.
	surface_tool.begin(Mesh.PRIMITIVE_TRIANGLES);
	
	# Add the first vertex to the surface tool (the bottom left vertex).
	# We have to add the normal and color BEFORE we add the vertex if we want them to be applied.
	surface_tool.add_normal(Vector3(0, 0, -1));
	surface_tool.add_color(Color(1, 0, 0, 1));
	surface_tool.add_vertex(Vector3(-1, 0, 0));
	
	# Add the second vertex to the surface tool (the bottom right vertex).
	surface_tool.add_normal(Vector3(0, 0, -1));
	surface_tool.add_color(Color(0, 1, 0, 1));
	surface_tool.add_vertex(Vector3(1, 0, 0));
	
	# Add the third vertex to the surface tool (the top vertex).
	surface_tool.add_normal(Vector3(0, 0, -1));
	surface_tool.add_color(Color(0, 0, 1, 1));
	surface_tool.add_vertex(Vector3(0, 2, 0));
	
	# Add the indices to the surface tool.
	# The indices tells the surface tool how to make a face with the given vertices.
	surface_tool.add_index(0);
	surface_tool.add_index(1);
	surface_tool.add_index(2);
	
	# Get the resulting mesh from the surface tool, and apply it to the MeshInstance.
	mesh = surface_tool.commit();

