extends Node
class_name SceneManager

@export var food_scene: PackedScene
@onready var food_container: Node2D = %food_container
@onready var countfood: Label = %Countfood
@onready var money_count: Label = %MoneyCount

@export var dolphin_scene : PackedScene
@onready var dolphin_container: Node = %dolphin_container
@export var price_per_dolphin : int = 30

@export var target_dolphins: int = 10
@onready var progress_target_dolphins: TextureProgressBar = %TextureProgressBar

@export var max_happiness:int= 100
var current_happiness: int = 0

@export var max_food :float = 100.0
var current_food :float = 0.0
@export var food_decay_rate := 1.5

@export var decay_per_zero_dolphin :float= 0.5
@export var correct_quiz_money : int = 100
@export var punishment_quiz_happines: int =5


@onready var player_food_progress: TextureProgressBar = %Player_food_progress
@onready var player_happines_progress: TextureProgressBar = %Player_Happines_progress
@onready var level_time: Timer = %LevelTime
@onready var timer_left: Label = %Timer_left

var threshold_hungry #less than 40%
var threshold_sadness #less than 40%

@onready var sad_anim: AnimationPlayer = $"../Sad"
@onready var hungry_anim: AnimationPlayer = $"../Hungry"

@onready var sadness_emote: TextureRect = $"../UIElements/Alerts_status/Sadness"
@onready var hugry_emote: TextureRect = $"../UIElements/Alerts_status/Hugry_emote"
var was_hungry := false
var was_sad := false

func _ready() -> void:
	
	
	GameManager.money_changed.connect(current_money)
	GameManager.dolphings_changed.connect(_on_updated_current_dolphins)
	GameManager.emotional_status_changed.connect(_on_emotional_changed)
	level_time.timeout.connect(_on_ended_level)
	GameManager.dolphin_food_actualizado.connect(_on_dolphin_food_changed)
	
	
	GameManager.correct_quiz_money = correct_quiz_money
	GameManager.punishment_quiz_happiness = punishment_quiz_happines
	
	GameManager.emotional_status = max_happiness
	GameManager.goal_dolphins = target_dolphins
	GameManager.current_food_container = GameManager.max_food_container
	progress_target_dolphins.max_value = target_dolphins
	countfood.text = str(GameManager.current_food_container)
	money_count.text = str(GameManager.global_money)
	
	GameManager.emotional_status = max_happiness
	player_happines_progress.value = GameManager.emotional_status 
	
	current_food = max_food
	player_food_progress.value = current_food
	
	threshold_hungry = max_food * 0.4
	threshold_sadness = max_happiness * 0.4

func _on_ended_level() -> void:
	# Final regular
	get_tree().change_scene_to_file("res://Scenes/Finales/final_bueno.tscn")
	print("Cambiar a final regular.")
	

func _check_endings()->void:
	if current_food <= 0 or GameManager.emotional_status  <= 0:
		get_tree().change_scene_to_file("res://Scenes/Finales/final_malo.tscn")
		print("Cambiar a final malo.")
	elif GameManager.current_dolphins >= target_dolphins:
		get_tree().change_scene_to_file("res://Scenes/Finales/final_perfecto.tscn")
		print("Cambiar a final perfecto.")


func _process(delta: float) -> void:
	_apply_decay_food(delta)
	_check_endings()
	_update_status_emotes() 
	var time = level_time.time_left
	var minutes = int(time) / 60
	var seconds = int(time) % 60
	timer_left.text = "%02d:%02d" % [minutes, seconds]

func _on_emotional_changed(emootional)->void:
	player_happines_progress.value = GameManager.emotional_status
	GameManager.emotional_status = clamp(GameManager.emotional_status, 0 , max_happiness)

func _on_updated_current_dolphins(number_dolphins)->void:
	progress_target_dolphins.value = number_dolphins

func _apply_decay_food(delta):
	current_food -= food_decay_rate * delta
	current_food = clamp(current_food, 0 ,max_food)
	player_food_progress.value = current_food
	
	if GameManager.current_dolphins == 0:
		GameManager.emotional_status -= decay_per_zero_dolphin * delta
	elif GameManager.current_dolphins > 0:
		GameManager.emotional_status += (decay_per_zero_dolphin * 0.5) * delta
		#player_happines_progress.value = current_happiness
	player_happines_progress.value = GameManager.emotional_status
func _update_status_emotes() -> void:
	var is_hungry = current_food <= threshold_hungry
	var is_sad = GameManager.emotional_status <= threshold_sadness

	
	hugry_emote.visible = is_hungry
	sadness_emote.visible = is_sad

	
	if is_hungry and not was_hungry:
		hungry_anim.play("Hungry")
	elif not is_hungry and was_hungry:
		hungry_anim.stop()

	if is_sad and not was_sad:
		sad_anim.play("Sadness")
	elif not is_sad and was_sad:
		sad_anim.stop()

	was_hungry = is_hungry
	was_sad = is_sad

func current_money()->void:
	money_count.text = str(GameManager.global_money)
func _on_feed_dolphins_button_pressed() -> void:
	if GameManager.current_food_container <= 0:
		print("no hay comida para delfines")
		return
	$"../Button_feed".play()
	GameManager.remove_dolphin_food(1)
	
	#GameManager.current_food_container-= 1
	#countfood.text = str(GameManager.current_food_container)
	_spawn_food()

func _on_dolphin_food_changed(count)->void:
	countfood.text = str(count)

func _spawn_food()->void:
	var food = food_scene.instantiate()
	food.position = food_container.position
	food.position.x = randf_range(-300,100)
	food.position.y -= 200
	food_container.add_child(food)
	
	


func _on_buy_dolphin_pressed() -> void:
	if GameManager.global_money > price_per_dolphin:
		GameManager.global_money -= price_per_dolphin
		spawn_dolphin()
		GameManager.money_changed.emit()
	else:
		%No_money_dolphin.play()

func spawn_dolphin()->void:
	var dolphin = dolphin_scene.instantiate()
	dolphin.position = dolphin_container.global_position
	dolphin.position.x = randf_range(-400,500)
	#dolphin.position.y -= 200
	dolphin_container.add_child(dolphin)
	
