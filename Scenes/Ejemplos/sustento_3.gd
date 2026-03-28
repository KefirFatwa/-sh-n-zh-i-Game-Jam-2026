extends Control

@export var velocidad_caida: float = 300.0
#este permite cargar varias pngs que son sprites, el orden es importante eso si
@export var texturas_ingredientes: Array[Texture2D] 

var ingredientes_en_aire: Array[Sprite2D] = []
var ingrediente_actual: int = 0
#este lleva los ingredientes que se han unido al gallo
var gallo_completado: int = 0

@onready var mano = $Mano
@onready var punto_agarre = $Mano/Marker2D
@onready var contenedor = $"ContenedorCaída"
@onready var sfx_resultado_bien = $SFX_Resultado_Bien
@onready var sfx_resultado_mal = $SFX_Resultado_Mal

func _ready():
	lanzar_siguiente_ingrediente()

func _process(delta):
	#controla que la mano se pueda mover nada mas
	var dir = Input.get_axis("ui_left", "ui_right")
	mano.position.x += dir * 600 * delta
	# es para que no se salga la mano
	mano.position.x = clamp(mano.position.x, 100, size.x -100)
	actualizar_ingredientes(delta)

func actualizar_ingredientes(delta):
	#recorre lista de primero a ultimo
	for i in range(ingredientes_en_aire.size() - 1, -1, -1):
		var item = ingredientes_en_aire[i]
		#gravedad
		item.position.y += velocidad_caida * delta
		#detecta si lo atrapo por medio de una distancia
		if item.position.distance_to(mano.position) < 100:
			atrapar_item(item, i)
			
			continue
		#si no lo atrapa por mamon
		if item.position.y > size.y:
			perder_juego(item,i)
			

func lanzar_siguiente_ingrediente():
	if ingrediente_actual > 2: return
	#crea ingrediente :D
	var nuevo_item = Sprite2D.new()
	nuevo_item.texture = texturas_ingredientes[ingrediente_actual]
	#tuve que meter esto porque al meter los assets resultaron ser mas grandes que lo que estaba trabajando sad uwu
	nuevo_item.scale = Vector2(0.5, 0.5)
	
	nuevo_item.position = Vector2(randf_range(50, size.x - 50), -50)
	add_child(nuevo_item)
	ingredientes_en_aire.append(nuevo_item)
	
func atrapar_item(item, indice_en_lista):
	#saca de lista de activos
	ingredientes_en_aire.remove_at(indice_en_lista)
	#pega a mano por jerarquia
	sfx_resultado_bien.play()
	item.get_parent().remove_child(item)
	punto_agarre.add_child(item)
	item.position = Vector2(0, -gallo_completado * 15)
	
	gallo_completado += 1
	ingrediente_actual += 1
	
	if gallo_completado == 3:
		#Aqui metemos tal vez nada mas que el jugador recibe full energia
		
		print("Gallo listo")
		finalizar_microjuego()
	else:
		get_tree().create_timer(1.0).timeout.connect(lanzar_siguiente_ingrediente)
	
	#Aqui metemos tal vez nada mas que el jugador recibe poco o nada de su hunger meter
func perder_juego(item, indice_en_lista):
	ingredientes_en_aire.remove_at(indice_en_lista)
	item.queue_free()
	sfx_resultado_mal.play()
	print("Sad salchi uwu")
	finalizar_microjuego()
	
func finalizar_microjuego():
	await get_tree().create_timer(2.0).timeout
	queue_free()
