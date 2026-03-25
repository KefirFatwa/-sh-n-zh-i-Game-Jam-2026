extends CharacterBody2D
class_name DolphinBase

var jump_velocity: Vector2 = Vector2.ZERO
const min_jump_strengh :float = 200
const max_jump_strengh :float = 500

var gravity_velocity = Vector2.ZERO
@export var GRAVITY_STRENGHT = 200
var gravity_dir = Vector2.DOWN

@onready var state_machine: StateMachine = $StateMachine
@onready var status_state: Label = $Status_state

@onready var down_raycast: RayCast2D = %Down_raycast
@onready var right_raycast: RayCast2D = %Right_raycast
@onready var left_raycast: RayCast2D = %Left_raycast

var is_pettable = false

var is_jumping: bool = false
var is_falling:bool = false
var is_happy:bool= false
var is_dying:bool= false
var is_death:bool= false

func _ready() -> void:
	state_machine.init(self)
	mouse_entered.connect(func():
		is_pettable = true)
	mouse_exited.connect(func():
		is_pettable = false)

func _input(event: InputEvent)-> void:
	state_machine.process_input(event)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)
	#if get_facing_raycast():
		#scale.x *= -scale.x
		#right_raycast.enabled = false
		#
		#get_tree().create_timer(2).timeout.connect(func():
			#left_raycast.enabled = true
			#right_raycast.enabled = true)
	
	status_state.text = str(state_machine.current_state.name)
	

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
	var is_facing_right = false
	var is_facing_left = false
	var facing_direction: Array = [is_facing_right,is_facing_left]

	var random_facing = facing_direction.pick_random()
	if random_facing == is_facing_right:
		is_facing_right = true
		is_facing_left = false
		scale.x = 1
	elif random_facing == is_facing_left:
		is_facing_left = true
		is_facing_right = false
		scale.x = -1
