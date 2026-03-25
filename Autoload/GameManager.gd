extends Node

var gameManager = true
var love_per_hit = 5
var damage_per_hit = 1


var max_food_container: int = 30
var current_food_container :int = 0

var correct_quiz_answers = 0
var shits_numbers : int = 0

signal shit_count(shit_coun: int)


func add_shits(shits_in_tank: int)->void:
	shits_numbers += shits_in_tank
	shit_count.emit(shits_numbers)


func remove_shits(shit_cleaned)->void:
	shits_numbers -= shit_cleaned
	shit_count.emit(shits_numbers)
