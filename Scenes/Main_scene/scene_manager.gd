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

@onready var player_food_progress: TextureProgressBar = %Player_food_progress
@onready var player_happines_progress: TextureProgressBar = %Player_Happines_progress


func _ready() -> void:
	
	
	GameManager.money_changed.connect(current_money)
	GameManager.dolphings_changed.connect(_on_updated_current_dolphins)
	
	GameManager.emotional_status_changed.connect(_on_emotional_changed)
	
	GameManager.emotional_status = max_happiness
	GameManager.goal_dolphins = target_dolphins
	GameManager.current_food_container = GameManager.max_food_container
	progress_target_dolphins.max_value = target_dolphins
	countfood.text = str(GameManager.current_food_container)
	money_count.text = str(GameManager.global_money)
	
	current_happiness = max_happiness
	player_happines_progress.value = current_happiness
	
	current_food = max_food
	player_food_progress.value = current_food

func _process(delta: float) -> void:
	_apply_decay_food(delta)

func _on_emotional_changed(emotional_status)->void:
	player_happines_progress.value = emotional_status
	
	current_happiness = clamp(current_happiness, 0 , max_happiness)

func _on_updated_current_dolphins(number_dolphins)->void:
	progress_target_dolphins.value = number_dolphins

func _apply_decay_food(delta):
	current_food -= food_decay_rate * delta
	current_food = clamp(current_food, 0 ,max_food)
	player_food_progress.value = current_food


func current_money()->void:
	money_count.text = str(GameManager.global_money)
func _on_feed_dolphins_button_pressed() -> void:
	if GameManager.current_food_container <= 0:
		print("no hay comida para delfines")
		return
	
	GameManager.current_food_container-= 1
	countfood.text = str(GameManager.current_food_container)
	_spawn_food()

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

func spawn_dolphin()->void:
	var dolphin = dolphin_scene.instantiate()
	dolphin.position = dolphin_container.global_position
	dolphin.position.x = randf_range(-400,500)
	#dolphin.position.y -= 200
	dolphin_container.add_child(dolphin)
	
