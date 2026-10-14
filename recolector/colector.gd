extends Area2D
## El colector que mueve el jugador. Junta partículas y decide si forman un hadrón.
## No toca el HUD directamente: AVISA con señales y main.gd decide qué mostrar.

# --- Señales: así el colector "avisa" a quien le interese ---
signal particula_formada(nombre: String, carga: int)
signal combinacion_invalida(contenido: Array)
signal grupo_cambiado(contenido: Array)

@export var speed = 400
@export var width = 120

var trapped = []          # símbolos atrapados en el grupo actual, ej. ["u", "anti-d"]
var n_quarks = 0
var n_antiquarks = 0
var total_charge = 0.0

# Nombres de hadrones conocidos con quarks u y d.
# La clave es la lista de símbolos ORDENADA y unida con comas,
# así no importa en qué orden se atraparon.
const NOMBRES = {
	"u,u,u": "Δ⁺⁺",
	"d,u,u": "protón",
	"d,d,u": "neutrón",
	"d,d,d": "Δ⁻",
	"anti-u,anti-u,anti-u": "anti-Δ⁺⁺",
	"anti-d,anti-u,anti-u": "antiprotón",
	"anti-d,anti-d,anti-u": "antineutrón",
	"anti-d,anti-d,anti-d": "anti-Δ⁻",
	"anti-d,u": "pion π⁺",
	"anti-u,d": "pion π⁻",
	"anti-u,u": "pion π⁰",
	"anti-d,d": "pion π⁰",
}


func _process(delta: float) -> void:
	var axis = Input.get_axis("ui_left", "ui_right")
	position.x += speed * delta * axis
	position.x = clamp(position.x, width / 2, get_viewport_rect().size.x - width / 2)


func _on_area_entered(area: Area2D) -> void:
	# Solo nos interesan las partículas (no otras áreas que agreguemos en el futuro)
	if not area.is_in_group("particulas"):
		return

	trapped.append(area.simbolo())
	if area.anti:
		n_antiquarks += 1
	else:
		n_quarks += 1
	total_charge += area.charge
	area.queue_free()

	evaluar_grupo()


## Reglas del juego (la carga de color): ver la tabla en TODO.md
func evaluar_grupo() -> void:
	if n_quarks == 1 and n_antiquarks == 1:
		formar("Mesón")
	elif n_quarks == 3:
		formar("Barión")
	elif n_antiquarks == 3:
		formar("Antibarión")
	elif n_quarks + n_antiquarks == 3:
		# 3 partículas mezcladas (2q + 1q̄ o 1q + 2q̄): no es color neutro
		combinacion_invalida.emit(trapped.duplicate())
		reiniciar()
	else:
		# Todavía no se decide: seguir atrapando
		grupo_cambiado.emit(trapped.duplicate())


func formar(familia: String) -> void:
	var copia = trapped.duplicate()
	copia.sort()
	var clave = ",".join(copia)
	var nombre = NOMBRES.get(clave, familia)   # si no está en la tabla, usa "Mesón"/"Barión"...
	if nombre != familia:
		nombre = familia + ": " + nombre
	# La carga de un hadrón siempre es entera: roundi() quita el error de los decimales
	particula_formada.emit(nombre, roundi(total_charge))
	reiniciar()


func reiniciar() -> void:
	trapped = []
	n_quarks = 0
	n_antiquarks = 0
	total_charge = 0.0
	grupo_cambiado.emit(trapped.duplicate())
