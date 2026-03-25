extends State
class_name HappyState

@onready var happy_state: HappyState = %HappyState
@onready var falling_state: FallingState = %FallingState

var mouse_hovered = false

func enter():
	super()
	

#func process_input(_event : InputEvent)->State:
	#if parent.is_pettable:
		#print("clicleando")
		#if _event.is_action_pressed("interaction_left_click"):
			#parent.scale.x *= -parent.scale.x
			#
			#return happy_state
#
	#return falling_state

func process_frame(_delta:float)->State:
	if parent.is_pettable and Input.is_action_just_pressed("interaction_left_click"):
		parent.scale.x *= -parent.scale.x
		return happy_state
		
	
	return happy_state
