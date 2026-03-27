extends Node
class_name StateMachine

@export var initial_state: State
var current_state: State



func init(parent: DolphinBase)->void:
	for child in get_children():
		if child is State:
			child.parent = parent
	if initial_state ==null:
		push_error("No hay estado inicial cargado")
		return
	change_state(initial_state)
	if initial_state is FallingState:
		parent.is_falling = true
	
func change_state(new_state: State)->void:
	if new_state == null:
		return
	
	if current_state:
		current_state.exit()
	
	current_state = new_state
	current_state.enter()
	

func process_input(event: InputEvent)->void:
	if current_state == null:
		return
	var new_state = current_state.process_input(event)
	if new_state:
		change_state(new_state)

func process_frame(delta: float) -> void:
	if current_state == null:
		return
	
	var new_state = current_state.process_frame(delta)
	if new_state:
		change_state(new_state)


func process_physics(delta: float) -> void:
	if current_state == null:
		return

	var new_state = current_state.process_physics(delta)
	if new_state:
		change_state(new_state)
