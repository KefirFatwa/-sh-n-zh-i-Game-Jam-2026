extends Control
class_name PhoneSceen


@onready var timer = %PopUpTimer
@onready var screen = %Screen
@onready var markerController = %MarkerController

var popUpScene = preload("res://Scenes/Celular/PopUp/PopUp.tscn")
var popUpScene2 = preload("res://Scenes/Celular/PopUp2/PopUp.tscn")
var popUps = [popUpScene, popUpScene2]

@onready var button_buy_feed: AudioStreamPlayer = $Button_buy_feed
@onready var not_money: AudioStreamPlayer = $Not_money

@onready var buy_chicken_button: Button = %Buy_Chicken_button
@onready var buy_noodles_button: Button = %Buy_noodles_button
@onready var buy_tacos_button: Button = %Buy_tacos_button
@onready var buy_dolphin_food_container: Button = %Buy_dolphin_food_container


@onready var price_chicken: Label = %Price_chicken
@onready var price_noodles: Label = %Price_noodles
@onready var price_tacos: Label = %price_Tacos
@onready var price_dolphin_food: Label = %price_dolphin_food




func _ready() -> void:
	price_chicken.text = str(GameManager.chicken_price)
	price_noodles.text = str(GameManager.noodles_price)
	price_tacos.text = str(GameManager.tacos_price)
	price_dolphin_food.text = str(GameManager.dolphin_food_price)
	
	buy_chicken_button.button_down.connect(_on_chicken_button_down)
	buy_noodles_button.button_down.connect(_on_noodles_button_down)
	buy_tacos_button.button_down.connect(_on_tacos_button_down)
	buy_dolphin_food_container.button_down.connect(_on_dolphin_button_down)


func _on_chicken_button_down()->void:
	if _check_threshold_price(GameManager.chicken_price):
		GameManager.add_food_chicken(1)
		button_buy_feed.play()
	else:
		not_money.play()
func _on_noodles_button_down()->void:
	if _check_threshold_price(GameManager.noodles_price):
		GameManager.add_food_maruchan(1)
		button_buy_feed.play()
	else:
		not_money.play()
func _on_tacos_button_down()->void:
	if _check_threshold_price(GameManager.tacos_price):
		GameManager.add_food_tacos(1)
		button_buy_feed.play()
	else:
		not_money.play()
func _on_dolphin_button_down()->void:
	if _check_threshold_price(GameManager.dolphin_food_price):
		GameManager.add_dolphin_food(GameManager.dolphin_food_packed)
		button_buy_feed.play()
	else:
		not_money.play()


func _check_threshold_price(food_price: int)->bool:
	if GameManager.global_money >= food_price:
		GameManager.global_money -= food_price
		return true
	return false


func _on_timer_timeout() -> void:
	create_popUp()
	
func create_popUp() -> void:
	var popUp: ColorRect = popUps.pick_random().instantiate()
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
