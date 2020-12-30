extends MeshInstance

const VERTEX_COLOR = Color(0, 0, 1, 1);

func _ready():
	# Make a new surface tool.
	var surface_tool = SurfaceTool.new();
	
	# Start the surface tool.
	# This time we'll start it in triangle fan mode, which makes it easier to
	# make shapes like hexagons.
	surface_tool.begin(Mesh.PRIMITIVE_TRIANGLE_FAN);
	
	# Add the vertices for a hexagon to the surface tool.
	# ============================================
	
	# Center vertex.
	surface_tool.add_normal(Vector3(0, 0, -1));
	surface_tool.add_color(VERTEX_COLOR);
	surface_tool.add_vertex(Vector3(0, 0, 0));
	
	# Middle left vertex.
	surface_tool.add_normal(Vector3(0, 0, -1));
	surface_tool.add_color(VERTEX_COLOR);
	surface_tool.add_vertex(Vector3(-1, 0, 0));
	
	# Bottom left vertex.
	surface_tool.add_normal(Vector3(0, 0, -1));
	surface_tool.add_color(VERTEX_COLOR);
	surface_tool.add_vertex(Vector3(-0.5, -1, 0));
	
	# Bottom right vertex.
	surface_tool.add_normal(Vector3(0, 0, -1));
	surface_tool.add_color(VERTEX_COLOR);
	surface_tool.add_vertex(Vector3(0.5, -1, 0));
	
	# Middle right vertex.
	surface_tool.add_normal(Vector3(0, 0, -1));
	surface_tool.add_color(VERTEX_COLOR);
	surface_tool.add_vertex(Vector3(1, 0, 0));
	
	# Top right vertex.
	surface_tool.add_normal(Vector3(0, 0, -1));
	surface_tool.add_color(VERTEX_COLOR);
	surface_tool.add_vertex(Vector3(0.5, 1, 0));
	
	# Top left vertex.
	surface_tool.add_normal(Vector3(0, 0, -1));
	surface_tool.add_color(VERTEX_COLOR);
	surface_tool.add_vertex(Vector3(-0.5, 1, 0));
	
	# Middle left vertex (which completes the loop)
	surface_tool.add_normal(Vector3(0, 0, -1));
	surface_tool.add_color(VERTEX_COLOR);
	surface_tool.add_vertex(Vector3(-1, 0, 0));
	# ============================================
	
	# NOTE: Because we using triangle fan mode in the surface tool, we do not need to
	# define the index order. This can make things a little easier, especially if you
	# have a lot of faces.
	
	# Get the resulting mesh from the surface tool, and apply it to the MeshInstance.
	mesh = surface_tool.commit();
