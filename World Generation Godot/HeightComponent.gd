@tool
extends Node

@onready var functions = %FunctionManager

func generate_height(pos):
	return model2(pos)

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
	var x = functions.factorial(functions.get_total(pos.x))
	var y = functions.factorial(functions.get_total(pos.y))
	return x / y
