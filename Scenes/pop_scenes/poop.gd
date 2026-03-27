extends CharacterBody2D
#caquita

@export var gravity  = 300
var gravity_dir = Vector2.DOWN

@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var health_component: HealthComponent = $HealthComponent
@onready var pop_sprite: Sprite2D = $Sprite2D

var is_hitable = false

@export var money_effect : PackedScene
 
var tween: Tween
@export var general_manager: GeneralManager
@onready var spawn: Marker2D = $Spawn


func _ready() -> void:
	GameManager.add_shits(1)
	health_component.is_death.connect(func():
		_spawn_money_effect()
		GameManager.updated_money(health_component.target_object.money_dropped)
		GameManager.remove_shits(1)
		queue_free()
		)


func _physics_process(delta: float) -> void:
	if ray_cast_2d.is_colliding():
		return
	if not is_on_floor():
		velocity += gravity_dir * gravity * delta
	move_and_slide()


func _input(event: InputEvent) -> void:
	if is_hitable:
		if Input.is_action_just_pressed("interaction_left_click"):
			health_component.decrease_health(GameManager.damage_per_hit)
			shake_hit()
			
			

func _spawn_money_effect()->void:
	var effect = money_effect.instantiate() as icon_money
	var pop_deposit = get_tree().get_first_node_in_group("pop_container")
	effect.position = spawn.position
	effect.scale = Vector2(0.5,0.5)
	effect.position.y += 350
	pop_deposit.add_child(effect)

func _on_mouse_entered() -> void:
	is_hitable = true

func _on_mouse_exited() -> void:
	is_hitable = false

func shake_hit()->void:
	if tween:
		tween.kill()
		tween = null
	
	tween = create_tween()
	tween.tween_property(pop_sprite, "offset:x",10,0.05)
	tween.tween_property(pop_sprite, "offset:x",-10,0.05)
	tween.tween_property(pop_sprite, "offset:x",0,0.05)
