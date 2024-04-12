@tool
extends Node
var noises = []
@onready var height_manager = %HeightManager

@export var update:bool

@export_category("Noise Settings")
@export var frequency = 0.1
@export var scale = 5
@export var layer_number = 3

func _ready():
	load_noise()

func load_noise():
	for i in layer_number:
		var noise = FastNoiseLite.new()
		noise.noise_type = FastNoiseLite.TYPE_PERLIN
		noise.frequency = frequency
		noises.append(noise)

func get_height_from_noise(pos):
	var value = 0
	for i in layer_number:
		value += noises[i].get_noise_2d(pos.x, pos.y) * (scale * 1/(i + 1)) 
	return value

func _process(delta):
	if update:
		load_noise()
		height_manager.update = true
		update = false
