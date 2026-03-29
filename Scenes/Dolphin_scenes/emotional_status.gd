extends Node
class_name GeneralManager


@export var max_food :float= 200.0
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

@onready var love_progress_bar: ProgressBar = %Love_progress_bar
@onready var hungre_progress_bar: ProgressBar = %Hungre_progress_bar
@onready var cleanest_progress_bar: ProgressBar = %Cleanest_progress_bar

@onready var dolphin_is_dying: AudioStreamPlayer = %Dolphin_is_dying
@onready var dying_animation: AnimationPlayer = %Dying_animation



var is_hungry :bool= false
var is_sad :bool= false
var is_dirty :bool= false

signal start_death_state

@onready var dolphin: AnimationPlayer = %Dolphin

@onready var dying: Sprite2D = $"../Dying"

func _ready():
	GameManager.shit_count.connect(_on_shits_changed)
	
	# Comida delfín sincronizada con progress bar default values
	current_food = max_food
	hungre_progress_bar.value = current_food
	hungre_progress_bar.max_value = current_food
	
	current_love = max_love
	cleanest_progress_bar.max_value = max_shit
	current_shit = max_shit

func _process(delta):
	_apply_decay(delta)
	_update_states()
	_update_UI_states()
	_check_death()
	_updated_animations()

func _updated_animations()->void:
	var food_ratio = current_food / max_food
	var status = _get_global_status()

	if food_ratio <= 0.3:
		_play_anim("moribundo")
		dying.visible = true
	elif food_ratio <= 0.4:
		_play_anim("normal")
		dying.visible = false
	elif status <= 0.5:
		_play_anim("moribundo")
		dying.visible = true
	elif status <= 0.8:
		_play_anim("normal")
		dying.visible = false
	else:
		_play_anim("happy")
		dying.visible = false

func _play_anim(name: String):
	if dolphin.current_animation != name:
		dolphin.play(name)
func _get_global_status() -> float:
	var food_ratio = current_food / max_food
	var love_ratio = current_love / max_love
	var clean_ratio = current_shit / max_shit
	
	return (food_ratio * 0.7) + (love_ratio * 0.2) + (clean_ratio * 0.2)
func _on_shits_changed(number_shits)->void:
	current_shit = clamp(max_shit - number_shits, 0, max_shit)
	_update_UI_states()

func _apply_decay(delta):
	current_food -= food_decay_rate * delta
	current_love -= love_decay_rate * delta

	current_food = clamp(current_food, 0, max_food)
	current_love = clamp(current_love, 0, max_love)

func _update_states():
	is_hungry = current_food <= hungry_threshold
	is_sad = current_love <= sad_threshold
	is_dirty = GameManager.shits_numbers >= max_shit

func _update_UI_states():
	love_progress_bar.value = current_love
	hungre_progress_bar.value = current_food
	cleanest_progress_bar.value = current_shit

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
