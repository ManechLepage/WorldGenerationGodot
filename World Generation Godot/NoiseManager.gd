@tool
extends Node
var noise:FastNoiseLite
@onready var height_manager = %HeightManager

@export var update:bool

@export_category("Noise Settings")
@export var frequency = 0.1
@export var scale = 5

func _ready():
	load_noise()

func load_noise():
	noise = FastNoiseLite.new()
	noise.noise_type = FastNoiseLite.TYPE_PERLIN
	noise.frequency = frequency

func get_height_from_noise(pos):
	return noise.get_noise_2d(pos.x, pos.y)

func _process(delta):
	if update:
		load_noise()
		height_manager.update = true
		update = false
