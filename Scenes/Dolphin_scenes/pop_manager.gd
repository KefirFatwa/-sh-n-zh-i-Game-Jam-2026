extends Node
class_name ShitManager

@export var pop_instance: PackedScene
@onready var timer: Timer = %Timer
@export var general_status: GeneralManager

@export var min_frequency_pop = 1
@export var max_frequency_pop = 2

func _ready():
	_random_time()
	timer.timeout.connect(_on_time_out)
	timer.start()

func _on_time_out():
	spawn_pops()

func spawn_pops():
	var pop = pop_instance.instantiate()
	var parent = get_tree().get_first_node_in_group("pop_container")
	pop.position = get_parent().global_position
	pop.general_manager = general_status
	
	get_parent().add_child(pop)
	pop.reparent(parent)
	_random_time()
	timer.start()
	

func _random_time():
	timer.wait_time = randf_range(min_frequency_pop, max_frequency_pop)
