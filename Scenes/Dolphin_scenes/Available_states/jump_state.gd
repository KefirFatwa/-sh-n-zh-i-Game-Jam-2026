extends State
class_name JumpState

@onready var falling_state: FallingState = %FallingState

@export var gravity_blend :float= 2.5
@export var max_speed :float= 220.0
@export var floatiness :float= 0.6 
@export var side_drift :float= 80.0  

var vel: Vector2
var bounce_cd := 0.0

func enter():
	super()
	
	var up_dir = -parent.gravity_dir.normalized()
	var base_force = parent.get_random_jump_strenght()
	var force = base_force * parent.jump_multiplier
	
	var side = randf_range(-80, 80)
	
	vel = up_dir * force
	vel.x += side
	
	if abs(vel.x) > 5:
		parent.base_dolphin.flip_h = vel.x < 0
		parent.eyes.flip_h =  vel.x < 0
	
	parent.velocity = vel
	bounce_cd = 0.0

	parent.jump_multiplier = 1.0


func process_physics(delta: float) -> State:
	bounce_cd -= delta
	
	var wall = parent.get_wall()
	if wall != Vector2.ZERO and bounce_cd <= 0.0:
		vel = vel.slide(wall) * 0.6 
		parent.velocity = vel
		
		if abs(vel.x) > 5:
			parent.base_dolphin.flip_h = vel.x < 0
			parent.eyes.flip_h =  vel.x < 0
		
		bounce_cd = 0.2
	
	var gravity_force = parent.GRAVITY_STRENGHT
	if vel.dot(parent.gravity_dir) < 0:
		gravity_force *= floatiness
	
	vel += parent.gravity_dir.normalized() * gravity_force * delta
	var target = vel.limit_length(max_speed)
	parent.velocity = parent.velocity.lerp(target, gravity_blend * delta)
	
	parent.move_and_slide()
	
	if vel.dot(parent.gravity_dir) > 20:
		return falling_state
	
	return null
