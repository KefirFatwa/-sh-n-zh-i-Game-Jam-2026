extends Node
#este es el singlenton gamemanager
var gameManager = true


var love_per_hit = 5
var damage_per_hit = 1


var max_food_container: int = 30
var current_food_container :int = 0

var pollo:int = 0
var marucha :int = 0
var tacos :int = 0



var emotional_status: int = 0


var goal_dolphins :int = 0
var current_dolphins : int = 0

var global_money : int = 0

var correct_quiz_money = 0
var punishment_quiz_money = 0
var punishment_quiz_happiness = 0


var shits_numbers : int = 0

signal shit_count(shit_coun: int)
signal money_changed
signal emotional_status_changed(emotional_status: int)
signal dolphings_changed(dolphin_count: int)
signal dolphin_has_death


func add_dolphins(value)->void:
	current_dolphins += value
	current_dolphins = clamp(current_dolphins, 0, goal_dolphins)
	dolphings_changed.emit(current_dolphins)

func remove_dolphins(value)->void:
	current_dolphins -= value
	current_dolphins = clamp(current_dolphins, 0, goal_dolphins)
	dolphings_changed.emit(current_dolphins)
	dolphin_has_death.emit()

func updated_money(value)->void:
	global_money += value
	money_changed.emit()

func add_emotional_status(value)->void:
	emotional_status += value
	emotional_status = clamp(emotional_status, 0 , 100)
	emotional_status_changed.emit(emotional_status)

func remove_emotional_status(value)->void:
	emotional_status -= value
	emotional_status = clamp(emotional_status, 0 , 100)
	emotional_status_changed.emit(emotional_status)

func add_shits(shits_in_tank: int)->void:
	shits_numbers += shits_in_tank
	shit_count.emit(shits_numbers)


func remove_shits(shit_cleaned)->void:
	shits_numbers -= shit_cleaned
	shit_count.emit(shits_numbers)
