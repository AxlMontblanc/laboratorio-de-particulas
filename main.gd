extends Node2D
## Controla una partida del Recolector: genera partículas, cuenta puntos y termina el juego.

const QUARK_SCENE = preload("res://recolector/quark.tscn")

@export var total_particulas = 30                 # X partículas por partida
@export var tipos_disponibles = ["u", "d"]         # sabores que pueden caer
@export var prob_anti = 0.4                        # probabilidad de que sea antiquark
@export var velocidad_min = 100.0
@export var velocidad_max = 170.0

var por_generar = 0      # partículas que aún no han aparecido
var activas = 0          # partículas en pantalla ahora
var puntaje = 0
var terminado = false
var tween_mensaje: Tween

@onready var colector = $Colector
@onready var hud_puntaje = $HUD/Puntaje
@onready var hud_restantes = $HUD/Restantes
@onready var hud_grupo = $HUD/Grupo
@onready var hud_mensaje = $HUD/Mensaje
@onready var hud_final = $HUD/Final


func _ready() -> void:
	por_generar = total_particulas

	# Conectar señales desde código (también se puede desde la pestaña Node)
	$SpawnTimer.timeout.connect(generar_particula)
	colector.particula_formada.connect(_on_particula_formada)
	colector.combinacion_invalida.connect(_on_combinacion_invalida)
	colector.grupo_cambiado.connect(_on_grupo_cambiado)

	hud_final.hide()
	actualizar_hud()
	mostrar_mensaje("¡Forma hadrones!", Color.WHITE)
	$SpawnTimer.start()


func _process(_delta: float) -> void:
	if terminado and Input.is_action_just_pressed("ui_accept"):
		get_tree().reload_current_scene()   # reiniciar la partida


func generar_particula() -> void:
	if por_generar <= 0:
		$SpawnTimer.stop()
		return

	var q = QUARK_SCENE.instantiate()
	# Asignar los datos ANTES de add_child, para que _ready() del quark ya los vea
	q.type = tipos_disponibles.pick_random()
	q.anti = randf() < prob_anti
	q.speed = randf_range(velocidad_min, velocidad_max)
	var ancho = get_viewport_rect().size.x
	q.position = Vector2(randf_range(30, ancho - 30), -20)
	# tree_exited se emite cuando el quark desaparece (atrapado o fuera de pantalla)
	q.tree_exited.connect(_on_particula_salio)
	add_child(q)

	por_generar -= 1
	activas += 1
	actualizar_hud()


func _on_particula_salio() -> void:
	if not is_inside_tree():   # pasa al reiniciar la escena: ignorar
		return
	activas -= 1
	if por_generar == 0 and activas == 0:
		terminar()


func _on_particula_formada(nombre: String, carga: int) -> void:
	puntaje += 1
	actualizar_hud()
	mostrar_mensaje("✔ %s  (carga %s)" % [nombre, formato_carga(carga)], Color(0.5, 1.0, 0.6))


func _on_combinacion_invalida(contenido: Array) -> void:
	mostrar_mensaje("✘ %s no es color neutro" % ", ".join(contenido), Color(1.0, 0.45, 0.45))


func _on_grupo_cambiado(contenido: Array) -> void:
	if contenido.is_empty():
		hud_grupo.text = "Colector: vacío"
	else:
		hud_grupo.text = "Colector: " + ", ".join(contenido)


func actualizar_hud() -> void:
	hud_puntaje.text = "Partículas formadas: %d" % puntaje
	hud_restantes.text = "Por caer: %d" % por_generar


func mostrar_mensaje(texto: String, color: Color) -> void:
	hud_mensaje.text = texto
	hud_mensaje.modulate = color
	# Un tween anima propiedades en el tiempo: espera 1 s y se desvanece en 0.5 s
	if tween_mensaje:
		tween_mensaje.kill()
	tween_mensaje = create_tween()
	tween_mensaje.tween_interval(1.0)
	tween_mensaje.tween_property(hud_mensaje, "modulate:a", 0.0, 0.5)


func terminar() -> void:
	terminado = true
	hud_final.text = "¡Fin!\nFormaste %d partículas\n\nPresiona Enter para jugar otra vez" % puntaje
	hud_final.show()


func formato_carga(q: int) -> String:
	if q > 0:
		return "+%d" % q
	return str(q)
