@tool
extends Node

@onready var functions = %FunctionManager
@onready var mesh_instance_3d = %MeshInstance3D
@onready var noise_manager = %NoiseManager

enum TerrainType 
{
	NOISE,
	BINARY_MOUNTAINS,
	TRIANGLES
}
@export var terrain_type:TerrainType
@export var radial:bool
@export var update:bool

func _process(delta):
	if update:
		update = false
		mesh_instance_3d.update = true

func generate_height(pos, center_pos):
	var value = 0
	if terrain_type == TerrainType.BINARY_MOUNTAINS:
		value = (model2(pos) * triangles(pos))
	elif terrain_type == TerrainType.TRIANGLES:
		value = triangles(pos)
	elif terrain_type == TerrainType.NOISE:
		value = generate_noise(pos)
	if radial:
		return value * (radial_map(pos, center_pos) * 2)
	return value

func radial_map(pos, center_pos):
	var distance = pos.distance_to(center_pos)
	var max_distance = center_pos.distance_to(Vector2.ZERO)

	var normalized_distance = 1.0 - (distance / max_distance)

	return clamp(normalized_distance, 0.0, 1.0)

func generate_noise(pos):
	return noise_manager.get_height_from_noise(pos) * 5

func test(pos):
	return sin(pos.x) * cos(pos.y)

func triangles(pos):
	var total = pos.x + pos.y
	var nbr_total = functions.get_total(pos.x) + functions.get_total(pos.y)
	var total_total = functions.get_total(total)
	
	var difference = nbr_total - total_total
	difference /= len(str(total)) ** 2
	return difference

func model2(pos):
	var a = functions.binary_score(pos.x)
	var b = functions.binary_score(pos.y)
	var c = sqrt(abs(a * b))
	return c
