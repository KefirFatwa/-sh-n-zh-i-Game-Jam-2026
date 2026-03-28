extends Control
class_name ComputerManager

@export var random_quiz: PackedScene
var is_question_active: bool = false
@onready var questin_container: TextureRect = %quest_container
@onready var timer: Timer = $Timer
@onready var alerta_examen: TextureRect = %AlertaExamen
@onready var test_active: AudioStreamPlayer = %Test_active


@onready var mini_games_manager: MiniGamesManager = $"../MiniGamesManager"



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.timeout.connect(on_time_out)
	

func _process(delta: float) -> void:
	if !mini_games_manager.is_computer_active and is_question_active:
		alerta_examen.visible = true
	else:
		alerta_examen.visible = false


func on_time_out()->void:
	if is_question_active:
		return
	
	_spawn_random_question()
	

	
func _spawn_random_question()->void:
	
	test_active.play()
	var question = random_quiz.instantiate()
	questin_container.add_child(question)
	is_question_active = true
