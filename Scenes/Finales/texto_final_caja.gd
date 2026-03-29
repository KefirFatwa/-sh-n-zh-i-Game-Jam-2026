extends ColorRect
@onready var texto_final = $TextoFinal

func _ready():
	texto_final.visible_ratio = 0
	mostrar_texto_lento()
	
	
	
func mostrar_texto_lento():
	var tween = create_tween()
	
	tween.tween_property(texto_final, "visible_ratio", 1.0, 3.0).set_trans(Tween.TRANS_LINEAR)
	
	
