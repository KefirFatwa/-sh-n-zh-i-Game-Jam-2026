extends State
class_name FallingState

@onready var eat_state: DyingState = %EatState
@onready var jump_state: JumpState = %JumpState
var floating_time : float =0.0
var random_time : float = randf_range(2,5)

func enter():
	super()
	if parent.gravity_velocity == Vector2.ZERO:
		parent.gravity_velocity = parent.velocity
		
	floating_time = 0

func process_physics(delta)-> State:
	floating_time += delta
	
	if parent.get_collider_raycast():
		parent.jump_multiplier = 1.0
		return jump_state
	
	elif floating_time >= random_time:
		parent.jump_multiplier = 0.5 
		return jump_state
	
	
	parent.gravity_velocity += parent.gravity_dir.normalized() * parent.GRAVITY_STRENGHT * delta
	var target_vel = parent.gravity_velocity.limit_length(100)
	parent.velocity = parent.velocity.lerp(target_vel, 1.0 * delta)
	parent.move_and_slide()
	
	return null
