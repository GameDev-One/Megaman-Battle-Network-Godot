extends MeshInstance

# A list to hold all of the vertices that have been added to make up the cube.
var array_quad_vertices = [];
# A list to hold all of the indices that have been added to make up the cube.
var array_quad_indices = [];

# A dictionary that we will use so we do not add duplicate vertices.
# This means we can have a closed mesh, with no floating faces.
#
# If you were making a NavMesh from code, it is super important that all faces
# in the NavMesh are connected if you want to have a working NavMesh.
var dictionary_check_quad_vertices = {};

# A constant variable to change the size of the cube.
const CUBE_SIZE = 0.5;


func _ready():
	# Call the make_cube function to make a cube.
	make_cube();


func make_cube():
	# Reset all of the mesh related class variables.
	array_quad_vertices = [];
	array_quad_indices = [];
	dictionary_check_quad_vertices = {};
	
	# Make a new mesh and surface tool.
	var result_mesh = Mesh.new();
	var surface_tool = SurfaceTool.new();
	
	# Tell the surface tool we are going to be making a mesh using triangles.
	# This means we'll need to keep track of the indices ourselves, but this will
	# give us better control over how the mesh is built.
	surface_tool.begin(Mesh.PRIMITIVE_TRIANGLES);
	
	# Define the four vertices that make up the top of the cube.
	var vert_north_topright = Vector3(-CUBE_SIZE, CUBE_SIZE, CUBE_SIZE);
	var vert_north_topleft = Vector3(CUBE_SIZE, CUBE_SIZE, CUBE_SIZE);
	var vert_north_bottomleft = Vector3(CUBE_SIZE, CUBE_SIZE, -CUBE_SIZE);
	var vert_north_bottomright = Vector3(-CUBE_SIZE, CUBE_SIZE, -CUBE_SIZE);
	
	# Define the four vertices that make up the bottom of the cube.
	var vert_south_topright = Vector3(-CUBE_SIZE, -CUBE_SIZE, CUBE_SIZE);
	var vert_south_topleft = Vector3(CUBE_SIZE, -CUBE_SIZE, CUBE_SIZE);
	var vert_south_bottomleft = Vector3(CUBE_SIZE, -CUBE_SIZE, -CUBE_SIZE);
	var vert_south_bottomright = Vector3(-CUBE_SIZE, -CUBE_SIZE, -CUBE_SIZE);
	
	
	# Make the six quads for needed to make a box!
	# ============================================
	# IMPORTANT: You have to input the points in the going either clockwise, or counter clockwise
	# or the add_quad function will not work!
	
	# Bottom quad (Negative Y)
	add_quad(vert_south_topright, vert_south_topleft, vert_south_bottomleft, vert_south_bottomright);
	# Top quad (Positive Y)
	add_quad(vert_north_topright, vert_north_bottomright, vert_north_bottomleft, vert_north_topleft);
	
	# South quad (Negative Z)
	add_quad(vert_north_bottomleft, vert_north_bottomright, vert_south_bottomright, vert_south_bottomleft);
	# North quad (Positive Z)
	add_quad(vert_north_topleft, vert_south_topleft, vert_south_topright, vert_north_topright);
	
	# East quad (Negative X)
	add_quad(vert_north_topright, vert_south_topright, vert_south_bottomright, vert_north_bottomright);
	# West quad (Positive X)
	add_quad(vert_north_topleft, vert_north_bottomleft, vert_south_bottomleft, vert_south_topleft);
	
	# ============================================
	
	# Add all of the vertices in array_quad_vertices to the surface tool
	for vertex in array_quad_vertices:
		surface_tool.add_vertex(vertex);
	# Add the indices in array_quad_indices to the surface tool
	for index in array_quad_indices:
		surface_tool.add_index(index);
	
	# Generate normals.
	# We could have generated normals ourselves, but it's easier to just let the surface
	# tool do it for us (in this case).
	surface_tool.generate_normals();
	
	# Get the resulting mesh from the surface tool, and apply it to the MeshInstance.
	result_mesh = surface_tool.commit();
	self.mesh = result_mesh;


func add_quad(point_1, point_2, point_3, point_4):
	
	# Define some variables that will store the index of each of the four passed in
	# vertices. We need this in case of the vertex has already been added before
	# so we can use that previously added vertex, which will remove any floating faces.
	var vertex_index_one = -1;
	var vertex_index_two = -1;
	var vertex_index_three = -1;
	var vertex_index_four = -1;
	
	# Check to see if each vertex already exists in the array.
	# If the vertex does not already exist, then it will be added and the index will be returned.
	# If the vertex already exists, then _add_or_get_vertex_from_array will return the index of the vertex.
	vertex_index_one = _add_or_get_vertex_from_array(point_1);
	vertex_index_two = _add_or_get_vertex_from_array(point_2);
	vertex_index_three = _add_or_get_vertex_from_array(point_3);
	vertex_index_four = _add_or_get_vertex_from_array(point_4);
	
	# Add the face indices for the two triangles that will make up this quad
	# (all quads/rectangular-faces are made from two triangles)
	#
	# Index order for the first triangle (IMPORTANT): 1, 2, 3
	# (The above index order will make a triangle going from vertices 1 -> 2 -> 3)
	array_quad_indices.append(vertex_index_one)
	array_quad_indices.append(vertex_index_two)
	array_quad_indices.append(vertex_index_three)
	
	# Index order for the second triangle (IMPORTANT): 1, 3, 4
	# (The above index order will make a triangle going from vertices 1 -> 3 -> 4)
	array_quad_indices.append(vertex_index_one)
	array_quad_indices.append(vertex_index_three)
	array_quad_indices.append(vertex_index_four)


func _add_or_get_vertex_from_array(vertex):
	# Check to see if the vertex already exists in dictionary_check_quad_vertices...
	if dictionary_check_quad_vertices.has(vertex) == true:
		# If it does, then return the index for that vertex, which is stored
		# in dictionary_check_quad_verticies.
		return dictionary_check_quad_vertices[vertex];
	
	# If the vertex does not already exist in dictionary_check_quad_vertices...
	else:
		# Add the vertex to array_quad_vertices.
		array_quad_vertices.append(vertex);
		# Add the vertex to dictionary_check_quad_vertices, making the key in the dictionary
		# to be the latest added vertex in array_quad_vertices.
		dictionary_check_quad_vertices[vertex] = array_quad_vertices.size()-1;
		return array_quad_vertices.size()-1;

