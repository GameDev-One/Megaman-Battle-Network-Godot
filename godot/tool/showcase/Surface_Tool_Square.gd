extends MeshInstance

func _ready():
	# Make a new surface tool.
	var surface_tool = SurfaceTool.new();

	# Start the surface tool.
	surface_tool.begin(Mesh.PRIMITIVE_TRIANGLES);

	# Add the first vertex to the surface tool (the top left vertex).
	surface_tool.add_normal(Vector3(0, 0, -1));
	surface_tool.add_color(Color(0, 0, 0, 1));
	surface_tool.add_vertex(Vector3(-1, 2, 1));
	
	# Add the second vertex to the surface tool (the bottom left vertex).
	surface_tool.add_normal(Vector3(0, 0, -1));
	surface_tool.add_color(Color(1, 0, 0, 1));
	surface_tool.add_vertex(Vector3(-1, 0, -1));
	
	# Add the third vertex to the surface tool (the bottom right vertex).
	surface_tool.add_normal(Vector3(0, 0, -1));
	surface_tool.add_color(Color(1, 0, 0, 1));
	surface_tool.add_vertex(Vector3(1, 0, -1));
	
	# Add the fourth vertex to the surface tool (the top right vertex).
	surface_tool.add_normal(Vector3(0, 0, -1));
	surface_tool.add_color(Color(0, 0, 0, 1));
	surface_tool.add_vertex(Vector3(1, 2, 1));

	# Add the indices to the surface tool.
	# Because a face is made of up two triangles, we'll need to add six indices.
	# First triangle
	surface_tool.add_index(0);
	surface_tool.add_index(1);
	surface_tool.add_index(2);
	# Second triangle
	surface_tool.add_index(0);
	surface_tool.add_index(2);
	surface_tool.add_index(3);

	# Get the resulting mesh from the surface tool, and apply it to the MeshInstance.
	mesh = surface_tool.commit();

