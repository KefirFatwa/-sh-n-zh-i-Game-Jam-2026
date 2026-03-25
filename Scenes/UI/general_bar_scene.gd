extends Control

@onready var progress_bar: ProgressBar = %ProgressBar
@export var health_com : HealthComponent
@onready var timer: Timer = %Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	progress_bar.max_value = health_com.maxHealth
	progress_bar.value = health_com.current_health
	
	health_com.updated_health.connect(_updated_bar)
	timer.timeout.connect(_on_time_out)
	visible = false

func _on_time_out()->void:
	visible = false

func _updated_bar(health)->void:
	progress_bar.value = health
	visible = true
	timer.start()
