extends Control

@onready var preguntaLabel = %PreguntaLabel
@onready var button = %Button
@onready var button2 = %Button2
@onready var button3 = %Button3
@onready var button4 = %Button4

var preguntas: Array = []
var preguntaActual = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	preguntas = load_json()
	set_questions(preguntas)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

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
		print("Escogiste la opción correcta")
	else:
		print("Te equivocaste!")
	
	disable_all_buttons()


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
