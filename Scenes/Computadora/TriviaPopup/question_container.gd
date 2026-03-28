extends Control

@onready var preguntaLabel = %PreguntaLabel
@onready var button = %Button
@onready var button2 = %Button2
@onready var button3 = %Button3
@onready var button4 = %Button4
@onready var timerLabel = %TimerLabel
@onready var timer = %Timer
@onready var progressBar = %ProgressBar

@onready var bad_answer: AudioStreamPlayer = $Bad_answer
@onready var correct_answer: AudioStreamPlayer = $Correct_answer



var preguntas: Array = []
var preguntaActual = {}

var timer_done: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	preguntas = load_json()
	set_questions(preguntas)
	
	# Set timer
	timer.wait_time = progressBar.value

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	handle_progress_bar()

func load_json():
	var file = FileAccess.open("res://Scenes/Computadora/TriviaPopup/questions.json", FileAccess.READ)
	var json = JSON.new()
	var result: Error = json.parse(file.get_as_text())
	if result != OK:
		print(json.get_error_line())
		print(json.get_error_message())
	else:
		return json.data

func set_questions(preguntas: Array):
	var pregunta = preguntas.pick_random()
	preguntaActual = pregunta
	preguntaLabel.text = pregunta["label"]

	var opciones = pregunta["opciones"]
	opciones.shuffle()
	button.text = opciones[0]["label"]
	button2.text = opciones[1]["label"]
	button3.text = opciones[2]["label"]
	button4.text = opciones[3]["label"]
	
func handle_on_click(button: Button):
	# Revisar si la opción es la correcta
	var opciones = preguntaActual["opciones"]
	var opcion = {}
	for x in opciones:
		if x.label == button.text:
			opcion = x
	var isCorrect = opcion["correcta"]
	if isCorrect:
		GameManager.global_money += GameManager.correct_quiz_money
		GameManager.money_changed.emit()
		button.modulate = Color("#44cc44")
		
		correct_answer.play()
		animation_notification().play("goodAnswer")
		print("Escogiste la opción correcta")
	else:
		GameManager.remove_emotional_status(GameManager.punishment_quiz_happiness)
		GameManager.emotional_status_changed.emit(GameManager.emotional_status)
		button.modulate = Color("#ff4444")
		bad_answer.play()
		animation_notification().play("badAnswer")
		print("Te equivocaste!")
	
	quit_question()

func quit_question() -> void:
	disable_all_buttons()
	_delete_question()
	timer.stop()

func animation_notification()->AnimationPlayer:
	return get_tree().get_first_node_in_group("NotificationManager")

func _delete_question() -> void:
	get_tree().create_timer(3).timeout.connect(func():
		get_tree().get_first_node_in_group("Computadora").is_question_active = false
		queue_free())
		
func handle_progress_bar() -> void:
	progressBar.value = timer.time_left
	timerLabel.text = str(timer.time_left).pad_decimals(2)
	if progressBar.value > 7:
		progressBar.modulate = Color("#44cc44")
	if progressBar.value > 4 and progressBar.value < 7:
		progressBar.modulate = Color("#ffdd00")
	if progressBar.value < 4:
		progressBar.modulate = Color("#ff4444")
	
	if timer.time_left == 0 and not timer_done:
		timer_done = true
		GameManager.remove_emotional_status(GameManager.punishment_quiz_happiness)
		GameManager.emotional_status_changed.emit(GameManager.emotional_status)
		print("EL TIEMPO ACABO.")
		quit_question()

func _on_button_pressed() -> void:
	handle_on_click(button)


func _on_button_2_pressed() -> void:
	handle_on_click(button2)


func _on_button_3_pressed() -> void:
	handle_on_click(button3)


func _on_button_4_pressed() -> void:
	handle_on_click(button4)
	
func disable_all_buttons():
	button.disabled = true
	button2.disabled = true
	button3.disabled = true
	button4.disabled = true
