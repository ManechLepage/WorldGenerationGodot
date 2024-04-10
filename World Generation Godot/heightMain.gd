extends Node

var n:FastNoiseLite

func load_noise():
	FastNoiseLite.new()
	n.noise_type = FastNoiseLite.TYPE_PERLIN

func model1(pos:Vector2):
	return n.get_noise_2d(pos.x, pos.y)
