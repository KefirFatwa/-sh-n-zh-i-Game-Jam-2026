extends Control
#lo siguiente es para 1 de de 3 microjuegos que podríamos hacer en la ventana de sustento
#idealmente un microjuego podr[ia mostrar m[as de una receta

@export var tiempo_meta: float  = 10
@export var margen_error: float = 1
@export var tiempo_maximo: float = 15

@onready var tapa = $Tapafideos
@onready var sopa_mala = $Sopitamala
@onready var sopa_lista = $Sopitalista
@onready var humo = $Humo
@onready var sfx_cocina = $SFX_Cocina
@onready var sfx_resultado_bien = $SFX_Resultado_Bien
@onready var sfx_resultado_mal = $SFX_Resultado_Mal


var tiempo_cocinado: float = 0
var cocinando: bool = false
var fin: bool = false

#COLORES DE POLLO
#var color_crudo = Color(1,1,0.7)
#var color_perfecto = Color(1, 0.6, 0)
#var color_quemado = Color(0.2, 0.1, 0)



#nada mas para que empiece en color crudo y sin humo
func _ready():
	humo.emitting = false
	tapa.visible = true
	sopa_lista.visible = false
	sopa_mala.visible = false
	empieza_a_cocinar()

	
#mientras que el pollo se cocina, cambia de color y vibra un poco
func _physics_process(delta: float):
	if cocinando and not fin:
		tiempo_cocinado += delta
		if tiempo_cocinado >= tiempo_maximo:
			termina_de_cocinar()

func _input(event):
	if event.is_action_pressed("cocina") and cocinando and not fin:
		termina_de_cocinar()
		

##Mueve el color del pollo conforme se acerca al color xico y luego pasa a color quemado
#func actualizar_color_pollo():
	#if tiempo_cocinado < tiempo_meta:
		#var t = tiempo_cocinado / tiempo_meta
		#pollo.modulate = color_crudo.lerp(color_perfecto, t)
	#else:
		#var t = (tiempo_cocinado - tiempo_meta) / (tiempo_maximo - tiempo_meta)
		#pollo.modulate = color_perfecto.lerp(color_quemado, t)

#Mueve un poquito el pollo, no es realista pero siento que hace la escena menos est[atica
#lo deje apagado porque me preocupa que se rompa al integrarlo al resto del juego
#func vibrar_pollo():
	#pollo.position = Vector2(randf_range(-1, 1), randf_range(-1,1)) 



#corre timer de cocinando, activa humo
func empieza_a_cocinar():
	cocinando = true
	humo.emitting = true
	humo.visible = true
	sfx_cocina.play()
	print("cocinando...")
	

#apaga timer de cocinando
func termina_de_cocinar():
	cocinando = false
	fin = true
	
	sfx_cocina.stop()
	humo.emitting = false
	humo.visible = false
	tapa.visible = false
	print("Lo removiste del calor, pasaron " + str(tiempo_cocinado) + " segundos")
	resultado()
	
	
func resultado():
	var diferencia = abs(tiempo_meta - tiempo_cocinado)
	if diferencia <= margen_error: 
		print("Se puede comer!")
		sfx_resultado_bien.play()
		sopa_lista.visible = true
		#aqui iria aja el codigo que sube la energia etc y en los otros 2 lo jodemos jeje
	elif tiempo_cocinado < tiempo_meta:
		print("IT's FUCKEN RAAAAW")
		sfx_resultado_mal.play()
		sopa_mala.visible = true
	else:
		print("La puta madreee, se quemó.") 
		sfx_resultado_mal.play()
		sopa_mala.visible = true
	await get_tree().create_timer(2.0).timeout
	queue_free()
