extends Control

@onready var button = %Button
@onready var timer = %PopUpTimer
@onready var screen = %Screen
@onready var markerController = %MarkerController

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
	create_popUp()
	
func create_popUp() -> void:
	var popUp: ColorRect = popUpScene.instantiate()
	var markers = markerController.get_children()
	var marker = markers.pick_random()
	if marker.get_children().size() < 1:
		marker.add_child(popUp)
		return
	
	var markers_without_children = markers.filter(func (m): 
		m.get_children().size() < 1)
	if markers_without_children.size() > 0:
		markers_without_children.pick_random().add_child(popUp)
		return
	print("No mas espacio para popups.")
