@tool
extends Node

func get_total(n):
	var chars = str(n)
	var char_sum = 0
	for i in chars:
		char_sum += int(i)
	return char_sum

func factorial(n: int) -> int:
	if n <= 1:
		return 1
	else:
		return n * factorial(n - 1)
