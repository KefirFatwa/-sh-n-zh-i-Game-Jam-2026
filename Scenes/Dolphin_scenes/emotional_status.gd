extends Node
class_name GeneralManager


@export var max_food :float= 100.0
@export var max_love :float= 100.0
@export var max_shit :float= 10

var current_food :float= 0.0
var current_love :float= 0.0
var current_shit :float= 0


@export var food_decay_rate :float= 5.0
@export var love_decay_rate :float= 2.0


@export var hungry_threshold :float= 30.0
@export var sad_threshold :float= 30.0
@export var increase_emotional_status: int = 10
@export var emotional_damage : int =5

var is_hungry :bool= false
var is_sad :bool= false
var is_dirty :bool= false

signal start_death_state



func _ready():
	current_food = max_food
	current_love = max_love
	current_shit = 0

func _process(delta):
	_apply_decay(delta)
	_update_states()
	_check_death()



func _apply_decay(delta):
	current_food -= food_decay_rate * delta
	current_love -= love_decay_rate * delta

	current_food = clamp(current_food, 0, max_food)
	current_love = clamp(current_love, 0, max_love)

func _update_states():
	is_hungry = current_food <= hungry_threshold
	is_sad = current_love <= sad_threshold
	is_dirty = GameManager.shits_numbers >= max_shit

func _check_death():
	if is_hungry and is_sad and is_dirty:
		start_death_state.emit()
	if current_food <= 0:
		start_death_state.emit()

func add_food(amount: float):
	current_food += amount
	current_food = clamp(current_food, 0, max_food)

func add_love(amount: float):
	current_love += amount
	current_love = clamp(current_love, 0, max_love)
