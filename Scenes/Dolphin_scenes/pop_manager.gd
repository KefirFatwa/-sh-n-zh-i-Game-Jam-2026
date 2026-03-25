extends Node
class_name ShitManager

@export var pop_instance : PackedScene
@onready var timer: Timer = %Timer

@export var min_frequency_pop = 1
@export var max_frequency_pop = 2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_random_time()
	timer.start()
	timer.timeout.connect(_on_time_out)
	
	

func _on_time_out()->void:
	spawn_pops()


func spawn_pops():
	
	var pop = pop_instance.instantiate()
	pop.position = get_parent().position
	var parent = get_tree().get_first_node_in_group("pop_container")
	parent.add_child(pop)
	_random_time()
	timer.start()

func _random_time()->void:
	timer.wait_time = randf_range(min_frequency_pop,max_frequency_pop)
