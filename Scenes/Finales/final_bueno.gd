extends Node

@onready var oceano = $oceano
@onready var estrellas = $estrellas
@onready var parlante_l = $parlanteL
@onready var parlante_r = $parlanteR
@onready var musica_nodos = [$parlanteL/musicaL, $parlanteL/musicaL2, $parlanteR/musicaR, $parlanteR/musicaR2]
@onready var delfines = $delfines

var tiempo : float = 0.0

func _process(delta: float):
	tiempo += delta
	
	#oceano
	oceano.position.y = sin(tiempo * 0.5) * 5
	#esstrellitas
	estrellas.visible = sin(tiempo * 10.0) > 0
	#parlantes
	var pulso = 0.5 + abs(sin(tiempo * 4.0)) * 0.2
	parlante_l.scale = Vector2(pulso, pulso)
	parlante_r.scale = Vector2(pulso, pulso)
	#musica
	var inclinacion = sin(tiempo*3.0) * 0.05
	for nota in musica_nodos:
		nota.skew = inclinacion
	#delfines
	delfines.position.y = abs(sin(tiempo * 15.0)) * -20
