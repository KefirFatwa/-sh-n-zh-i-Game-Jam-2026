extends CharacterBody2D
class_name DolphinBase

var jump_velocity: Vector2 = Vector2.ZERO
const min_jump_strengh :float = 200
const max_jump_strengh :float = 500

var gravity_velocity = Vector2.ZERO
@export var GRAVITY_STRENGHT = 200
var gravity_dir = Vector2.DOWN
var jump_multiplier: float = 1.0

@onready var state_machine: StateMachine = $StateMachine

@onready var down_raycast: RayCast2D = %Down_raycast
@onready var right_raycast: RayCast2D = %Right_raycast
@onready var left_raycast: RayCast2D = %Left_raycast

@onready var general_manager: GeneralManager = $General_Manager

@export var dealth_dolphin_scene : PackedScene

@onready var base_dolphin: Sprite2D = $Base_Dolphin
@onready var eyes: Sprite2D = $Base_Dolphin/Eyes

var is_pettable = false

var is_jumping: bool = false
var is_falling:bool = false
var is_happy:bool= false
var is_dying:bool= false
var is_death:bool= false

var dolphin_tween: Tween
@onready var status_ui: Control = %Status_UI

func _ready() -> void:
	state_machine.init(self)
	GameManager.add_emotional_status(general_manager.increase_emotional_status)
	GameManager.add_dolphins(1)
	mouse_entered.connect(func():
		status_ui.visible = true
		zoom_dolphin_hovered(self, Vector2(1.1,1.1))
		is_pettable = true)
	mouse_exited.connect(func():
		status_ui.visible = false
		zoom_dolphin_hovered(self, Vector2(1,1))
		is_pettable = false)
	general_manager.start_death_state.connect(death_dolphin)

func death_dolphin():
	var death_body = dealth_dolphin_scene.instantiate()
	death_body.position = global_position
	get_tree().get_first_node_in_group("dolphinContainer").add_child(death_body)
	GameManager.remove_emotional_status(general_manager.emotional_damage)
	GameManager.remove_dolphins(1)
	GameManager.dolphin_has_death.emit()
	queue_free()

func _input(event: InputEvent)-> void:
	state_machine.process_input(event)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func get_collider_raycast()->bool:
	return down_raycast.is_colliding()
	
func get_wall() -> Vector2:
	if right_raycast.is_colliding():
		return Vector2.LEFT
	elif left_raycast.is_colliding():
		return Vector2.RIGHT
	return Vector2.ZERO
	
func get_random_jump_strenght()->float:
	return randf_range(min_jump_strengh,max_jump_strengh)

func _pick_initial_facing()->void:
	var dir = [-1, 1].pick_random()
	base_dolphin.flip_h = dir < 0
	eyes.flip_h = dir< 0


func zoom_dolphin_hovered(dolphin: DolphinBase, zoom_intensity: Vector2)->void:
	if dolphin_tween:
		dolphin_tween.kill()
		dolphin_tween = null
	var initial_rot = dolphin.rotation_degrees
	
	dolphin_tween= create_tween()
	#este controla el zoom
	dolphin_tween.parallel().tween_property(dolphin,"scale",zoom_intensity, 0.1)
