@tool
extends Node

# Returns the sum of the digits
func get_total(n):
	var digits = str(n)
	var digits_sum = 0
	for i in digits:
		digits_sum += int(i)
	return digits_sum

# Returns the factorial value of the number
func factorial(n):
	if n <= 1:
		return 1
	else:
		return n * factorial(n - 1)

# Returns the product of the digits
func multiply_digits(n):
	var digits = str(n)
	var digits_product = 1
	for i in digits:
		digits_product *= int(i)
	return digits_product

# Returns a score that is +1 for every one and -1 for every 0 in the binary value of the number
func binary_score(n):
	var b = dec2bin(n)
	var digits = str(b)
	var score = 0
	for i in digits:
		if i == "0":
			score += 1
		else:
			score -= 1
	return score

# Returns the binary value of a decimal
func dec2bin(decimal_number):
	decimal_number = int(decimal_number)
	var binary_number = 0
	var base = 1

	while decimal_number > 0:
		binary_number += (decimal_number % 2) * base
		decimal_number /= 2
		base *= 10

	return binary_number
