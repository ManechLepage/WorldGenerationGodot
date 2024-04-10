@tool
extends MeshInstance3D

@export var size = 20

@export var update = false
@export var clear_virt_viz = false
@onready var height_manager = %HeightManager

func _ready():
	generate_terrain()
	generate_colors()

func generate_terrain():
	var a_mesh:ArrayMesh
	var surftool = SurfaceTool.new()
	
	surftool.begin(Mesh.PRIMITIVE_TRIANGLES)
	
	for z in size + 1:
		for x in size + 1:
			var y = height_manager.generate_height(Vector2(x, z), Vector2(size / 2, size / 2))
			
			surftool.add_vertex(Vector3(x, y, z))
			draw_sphere(Vector3(x, y, z))
	
	var vert = 0
	for z in size:
		for x in size:
			surftool.add_index(vert + 0)
			surftool.add_index(vert + 1)
			surftool.add_index(vert + size + 1)
			surftool.add_index(vert + size + 1)
			surftool.add_index(vert + 1)
			surftool.add_index(vert + size + 2)
			vert += 1
		vert += 1
	
	surftool.generate_normals()
	a_mesh = surftool.commit()
	mesh = a_mesh

func generate_colors():
	pass

func draw_sphere(pos:Vector3):
	var ins = MeshInstance3D.new()
	add_child(ins)
	ins.position = pos
	var sphere = SphereMesh.new()
	sphere.radius = 0.1
	sphere.height = 0.2
	ins.mesh = sphere

func _process(delta):
	if update:
		generate_terrain()
		generate_colors()
		update = false
	if clear_virt_viz:
		for i in get_children():
			i.free()
