extends State
class_name JumpState

@onready var falling_state: FallingState = %FallingState

@export var gravity_blend := 4.0

var vel: Vector2
var bounce_cd := 0.0

func enter():
	super()
	
	var dir = -parent.gravity_dir.normalized()
	var force = parent.get_random_jump_strenght()
	var side = randi_range(-200, 200)
	
	vel = dir * force
	vel.x += side
	
	
	if vel.x != 0:
		parent.scale.x = sign(vel.x)
	
	parent.velocity = vel
	bounce_cd = 0.0


func process_physics(delta: float) -> State:
	bounce_cd -= delta
	
	var wall = parent.get_wall()
	if wall != Vector2.ZERO and bounce_cd <= 0.0:
		vel = vel.bounce(wall)
		parent.velocity = vel
		
		if abs(vel.x) > 5:
			parent.scale.x = sign(vel.x)
		
		bounce_cd = 0.1
	
	
	vel += parent.gravity_dir.normalized() * parent.GRAVITY_STRENGHT * delta
	
	var capped = vel.limit_length(300)
	parent.velocity = parent.velocity.lerp(capped, gravity_blend * delta)
	
	parent.move_and_slide()
	
	
	if parent.velocity.dot(parent.gravity_dir) > 0:
		return falling_state
	
	return null
