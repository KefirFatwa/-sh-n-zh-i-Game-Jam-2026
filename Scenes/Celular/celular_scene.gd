extends Control

@onready var button = %Button
@onready var timer = %PopUpTimer
@onready var popUpSpawnLocation: PathFollow2D = %PopUpSpawnLocation

var popUpScene = preload("res://Scenes/Celular/PopUp/PopUp.tscn")

# Reemplazar con variables globales
var food_amount = 0
var money_amount = 100
var food_price = 16

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	if money_amount > food_price:
		money_amount -= food_price
		food_amount += 1
	else:
		print("no tienes suficiente dinero.")


func _on_timer_timeout() -> void:
	var popUp: ColorRect = popUpScene.instantiate()
	popUpSpawnLocation.progress_ratio = randf()
	popUp.position = popUpSpawnLocation.position
	add_child(popUp)
