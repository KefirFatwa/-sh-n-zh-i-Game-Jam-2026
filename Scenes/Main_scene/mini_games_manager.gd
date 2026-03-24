extends Node
class_name MiniGamesManager

#este script se encarga unicamente de las transiciones entre las UI y sus
#respectivos minijuegos, es un script largo pero es para tener control
#del flujo, 


#referencia a todos los botones de la UI
@onready var phone_interaction_button: TextureButton = %Phone_Interaction_button
@onready var pc_interaction_button: TextureButton = %PC_Interaction_button
@onready var door_interaction_button: TextureButton = %Door_Interaction_button2
@onready var cook_interaction_button: TextureButton = %Cook_Interaction_button
@onready var room_interaction_button: TextureButton = %Room_Interaction_button

#referencia al contenedor de los botones
@onready var interactables_buttons: Control = $"../Interactables_buttons"


#referencia de los botones que cierran cada UI de minijuego
@onready var close_phone_UI: Button = %close_phone
@onready var close_pc: Button = %close_Pc
@onready var close_cook: Button = %close_cook


#referencia a los contenedores de cada minijuego
@onready var phone: Control = %Telefono
@onready var pc: Control = %Computadora
@onready var cook: Control = %Cocina


#encargado del efecto blur del fondo
@onready var blur_background: ColorRect = %BlurBackground

#referencia a la camara
@onready var main_camera: Camera2D = %MainCamera

#algunas comprobaciones adicionales para ocultar elementos del canvas_layer
var is_phone_active: bool = false
var is_door_active : bool = false
var is_mouse_hovered: bool = false

#tweens que se encargan de la animacion de cada boton o UI
var container_tween : Tween
var button_tween: Tween
var camera_tween: Tween

#variables para setear algunas cosas rapido
@export var min_zoom_button:Vector2= Vector2(1,1)
@export var max_zoom_button:Vector2 = Vector2(1.1,1.1)

@export var shake_intensity: float = 20
@export var transition_duration: float = 0.3

@export var room_speed_transition : float = 0.5

@export var min_max_zoom_UI : Vector2 = Vector2(1,1)
@export var max_max_zoom_UI : Vector2 = Vector2(1.5,1.5)

func _ready() -> void:
	#signals que estan contectadas para un mejor control por codigo
	#esta es la signal del phone UI
	phone_interaction_button.button_down.connect(_on_open_phone_UI)
	close_phone_UI.button_down.connect(_on_close_phone_UI)
	phone_interaction_button.mouse_entered.connect(_on_entered_open_phone_button)
	phone_interaction_button.mouse_exited.connect(_on_exited_open_phone_button)
	
	#este es el signal del PC
	pc_interaction_button.button_down.connect(_on_opened_pc_UI)
	pc_interaction_button.mouse_entered.connect(_on_entered_open_pc_button)
	pc_interaction_button.mouse_exited.connect(_on_exited_open_pc_button)
	close_pc.button_down.connect(_on_closed_pc_UI)
	
	#este es el signal de la cocina
	cook_interaction_button.button_down.connect(_on_opened_cook_UI)
	cook_interaction_button.mouse_entered.connect(_on_entered_cook_button)
	cook_interaction_button.mouse_exited.connect(_on_exited_cook_button)
	close_cook.button_down.connect(_on_closed_cook_UI)
	#
	#este es el signal de la puerta
	door_interaction_button.button_down.connect(_on_opened_door_UI)
	door_interaction_button.mouse_entered.connect(_on_entered_door_button)
	door_interaction_button.mouse_exited.connect(_on_exited_door_button)
	
	#este es el signal de la habitacion
	room_interaction_button.button_down.connect(_on_opened_room_UI)
	room_interaction_button.mouse_entered.connect(_on_entered_room_button)
	room_interaction_button.mouse_exited.connect(_on_exited_room_button)

#comportamiento del telefono
func _on_open_phone_UI()->void:
	_tween_UI_container(container_tween,phone,Vector2(673,173),transition_duration,false,0, 0,8,max_max_zoom_UI)

func _on_close_phone_UI()->void:
	_tween_UI_container(container_tween,phone,Vector2(0,1600),transition_duration,true,-60, 8,0,min_max_zoom_UI)

func _on_entered_open_phone_button()->void:
	_shake_and_zoom_button(phone_interaction_button,max_zoom_button)
	is_mouse_hovered = true

func _on_exited_open_phone_button()->void:
	_shake_and_zoom_button(phone_interaction_button,min_zoom_button)
	is_mouse_hovered = false

#comportamiento del pc
func _on_opened_pc_UI()->void:
	_tween_UI_container(container_tween,pc,Vector2(480,170),transition_duration,false,0, 0,8,max_max_zoom_UI)
func _on_entered_open_pc_button()->void:
	_shake_and_zoom_button(pc_interaction_button,max_zoom_button)
func _on_exited_open_pc_button()->void:
	_shake_and_zoom_button(pc_interaction_button,min_zoom_button)
func  _on_closed_pc_UI()->void:
	_tween_UI_container(container_tween,pc,Vector2(2050,940),transition_duration,true,20,8,0,min_max_zoom_UI)

#comportamiento de la comida

func _on_opened_cook_UI()->void:
	_tween_UI_container(container_tween,cook,Vector2(230,165),transition_duration,false,0, 0,8,max_max_zoom_UI)
func  _on_entered_cook_button()->void:
	_shake_and_zoom_button(cook_interaction_button,max_zoom_button)
func _on_exited_cook_button()->void:
	_shake_and_zoom_button(cook_interaction_button,min_zoom_button)
func _on_closed_cook_UI()->void:
	_tween_UI_container(container_tween,cook,Vector2(230,1170),transition_duration,true,0, 8,0,min_max_zoom_UI)

#comportamiento de la puerta
func _on_opened_door_UI()->void:
	if camera_tween:
		camera_tween.kill()
		camera_tween = null
		
	camera_tween=  create_tween()
	camera_tween.tween_property(main_camera,"position",Vector2(-5000,0),room_speed_transition)
	
	is_door_active = true
	_set_active_button(false)
	
func _on_entered_door_button()->void:
	_shake_and_zoom_button(door_interaction_button,max_zoom_button)
func _on_exited_door_button()->void:
	_shake_and_zoom_button(door_interaction_button,min_zoom_button)

#comportamiento de la habitacion
func _on_opened_room_UI()->void:
	if camera_tween:
		camera_tween.kill()
		camera_tween = null
		
	camera_tween=  create_tween()
	camera_tween.tween_property(main_camera,"position",Vector2(0,0),room_speed_transition)
	
	is_door_active = false
	_set_active_button(true)
func _on_entered_room_button()->void:
	_shake_and_zoom_button(room_interaction_button,max_zoom_button)
func _on_exited_room_button()->void:
	_shake_and_zoom_button(room_interaction_button,min_zoom_button)

#metodos adicionales para darle game Juice al juego
func _set_blur(intensity: int)->void:
	var mat = blur_background.material
	if mat is ShaderMaterial:
		mat.set_shader_parameter("samples",intensity)

func _shake_and_zoom_button(button: TextureButton, zoom_intensity: Vector2)->void:
	if button_tween:
		button_tween.kill()
		button_tween = null
	var initial_rot = button.rotation_degrees
	
	button_tween= create_tween()
	#este controla el zoom
	button_tween.parallel().tween_property(button,"scale",zoom_intensity, 0.1)
	#este controla el shake
	#desactivado de momento
	#if is_mouse_hovered:
		#button_tween.tween_property(button,"rotation_degrees",button.rotation_degrees + shake_intensity, 0.1)
		#button_tween.tween_property(button,"rotation_degrees",button.rotation_degrees -shake_intensity, 0.1)
		#button_tween.tween_property(button,"rotation_degrees",initial_rot, 0.1)

func _set_active_button(status_button : bool)->void:
	var buttons = interactables_buttons.get_children()
	for button in buttons:
		button.visible = status_button
		
	
	if is_door_active:
		room_interaction_button.visible = true
	else:
		room_interaction_button.visible = false

func _tween_UI_container(type_tween: Tween, UI_container: Control, to_pos: Vector2, max_duration: float, stats_butt: bool, rotation : float, blur_from: float, blur_to : float, zoom: Vector2):
	if type_tween:
		type_tween.kill()
		type_tween = null
		
	type_tween = create_tween()
	type_tween.parallel().tween_property(UI_container, "position", to_pos,max_duration)
	type_tween.parallel().tween_property(UI_container,"rotation_degrees",rotation, max_duration)
	type_tween.parallel().tween_property(main_camera,"zoom",zoom, max_duration)
	type_tween.parallel().tween_method(_set_blur,blur_from,blur_to,0.3)
	_set_active_button(stats_butt)
