extends Control
class_name ComputerManager

@export var random_quiz: PackedScene
var is_question_active: bool = false
@onready var questin_container: TextureRect = %quest_container
@onready var timer: Timer = $Timer





# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.timeout.connect(on_time_out)
	


func on_time_out()->void:
	if is_question_active:
		return
	
	_spawn_random_question()
	

	
func _spawn_random_question()->void:
	var question = random_quiz.instantiate()
	questin_container.add_child(question)
	is_question_active = true
