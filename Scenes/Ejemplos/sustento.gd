extends Control
#lo siguiente es para 1 de de 3 microjuegos que podríamos hacer en la ventana de sustento
#idealmente un microjuego podr[ia mostrar m[as de una receta
@export var tiempo_meta: float  = 5
@export var margen_error: float = 2
var tiempo_cocinado: float = 0

var cocinando: bool = false


#------------------------------------------------------------------------------------------

func _process(delta: float):
	if cocinando:
		tiempo_cocinado += delta
		#codigo de cocinando aqui
		#animacion de cocinando aqui

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if not cocinando:
			empieza_a_cocinar()
		else:
			termina_de_cocinar()
			
func empieza_a_cocinar():
	cocinando = true
	tiempo_cocinado = 0
	print("cocinando...")
 	
func termina_de_cocinar():
	cocinando = false
	print("Lo removiste del calor, pasaron " + str(tiempo_cocinado) + " segundos")
	resultado()
	
	
func resultado():
	var diferencia = abs(tiempo_meta - tiempo_cocinado)
	if diferencia <= margen_error: print("Se puede comer!")
	#codigo de cambio de sprite va aca
	elif tiempo_cocinado < tiempo_meta: print("IT's FUCKEN RAAAAW")
	#codigo de comida cruda aca, sprite y afecta el main game
	else:print("La puta madreee, se quemó.")
	#codigo de basura quemada aca, sprite y afecta el main game 
