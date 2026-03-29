extends Node
#este es el singlenton gamemanager
var gameManager = true


var love_per_hit = 5
var damage_per_hit = 1


var max_food_container: int = 50
var current_food_container :int = 0


var pollo_cantidad: int = 1
var maruchan_cantidad: int = 1
var taco_cantidad: int = 1

signal pollo_actualizado(cant_pollo:int)
signal maruchan_actualizado(cant_marucha:int)
signal taco_actualizado(cant_taco:int)
signal dolphin_food_actualizado(cant_dolphin_food:int)

var pollo_comido:int = 40
var maruchan_comido :int = 20
var tacos_comido :int = 30

var chicken_price = 30
var noodles_price = 20
var tacos_price = 40
var dolphin_food_price = 20

var health_chicken = 30
var health_noodles = 20
var health_tacos = 40
var dolphin_food_packed = 10


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

var tutorial_activo: bool = true

func add_dolphin_food(value:int)->void:
	current_food_container += value
	dolphin_food_actualizado.emit(current_food_container)
	
func remove_dolphin_food(value:int)->void:
	current_food_container -= value
	dolphin_food_actualizado.emit(current_food_container)

func add_food_chicken(value:int)->void:
	pollo_cantidad += value
	pollo_actualizado.emit(pollo_cantidad)

func add_food_maruchan(value:int)->void:
	maruchan_cantidad += value
	maruchan_actualizado.emit(maruchan_cantidad)
	
func add_food_tacos(value:int)->void:
	taco_cantidad += value
	taco_actualizado.emit(taco_cantidad)

func remove_food_pollo(value:int)->void:
	pollo_cantidad -= value
	pollo_actualizado.emit(pollo_cantidad)
	
func remove_food_maruchan(value:int)->void:
	maruchan_cantidad -= value
	maruchan_actualizado.emit(maruchan_cantidad)
	
func remove_food_tacos(value:int)->void:
	taco_cantidad -= value
	taco_actualizado.emit(taco_cantidad)


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


#Dejo esto aca al final por si luego jode algo, pero es para resettear variables del juego cuando el jugador juega reiteradas veces
func reset_game_data():
	current_dolphins = 0
