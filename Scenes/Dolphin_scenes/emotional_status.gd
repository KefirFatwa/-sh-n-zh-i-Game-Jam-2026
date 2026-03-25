extends Node
class_name GeneralManager

#general data (could be replaced with resources)
var max_food = 10
var max_clean = 3
var max_love = 10

var current_food
var current_love
var current_clean

#status for die
var is_dirt :bool = false
var is_hungry: bool= false
var is_sad: bool = false

signal start_death_state
@onready var love_status_manager: LoveManager = %Love_Status_Manager


@onready var clean: Label = $"../Debug_states/VBoxContainer/Clean"
@onready var love: Label = $"../Debug_states/VBoxContainer/Love"
@onready var food: Label = $"../Debug_states/VBoxContainer/Food"


func _ready() -> void:
	GameManager.shit_count.connect(_on_to_much_shit)
	current_food = max_food
	current_clean = max_clean
	current_love = max_love


func _process(delta: float) -> void:
	clean.text = "Clean State: " + str(is_dirt)
	love.text = "Love State: " + str(love_status_manager.is_sad)
	food.text = "Food State: " + str(is_hungry)

func _on_to_much_shit(count_shit: int)->void:
	
	if current_clean <= count_shit:
		is_dirt = true
	else:
		is_dirt = false
	if is_ready_to_die() and love_status_manager.is_sad:
		start_death_state.emit()
func is_ready_to_die()->bool:
	return is_dirt and is_hungry and is_sad
