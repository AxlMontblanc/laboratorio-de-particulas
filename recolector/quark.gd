extends Area2D
## Una partícula que cae: puede ser un quark o un antiquark.
## El DATO (type, anti) manda; el dibujo y la etiqueta solo lo reflejan.

@export var speed = 100
@export var type = "u"
@export var anti = false   # true = antiquark

# Los dos grupos de quarks según su carga
const pquarks = ["u", "c", "t"]   # carga +2/3
const nquarks = ["d", "s", "b"]   # carga -1/3

# Color de cada sabor (para el dibujo)
const COLORES = {
	"u": Color(1.0, 0.45, 0.35),   # rojo anaranjado
	"d": Color(0.35, 0.65, 1.0),   # azul
	"c": Color(1.0, 0.8, 0.3),
	"s": Color(0.5, 0.9, 0.6),
	"t": Color(1.0, 0.5, 0.8),
	"b": Color(0.7, 0.55, 1.0),
}
const RADIO = 15.0
const FONDO_ANTI = Color(0.06, 0.07, 0.14)

var charge: float = 0.0


func _ready() -> void:
	# El grupo permite que el colector reconozca "esto es una partícula"
	add_to_group("particulas")

	$Label.text = type
	if type in pquarks:
		charge = 2.0 / 3.0
	elif type in nquarks:
		charge = -1.0 / 3.0
	else:
		push_warning("Tipo de quark desconocido: " + type)

	# Un antiquark tiene la carga opuesta a su quark
	if anti:
		charge = -charge

	# Quark: letra oscura sobre círculo de color. Antiquark: letra de color sobre fondo oscuro.
	var color_letra = mi_color() if anti else Color(0.05, 0.05, 0.1)
	$Label.add_theme_color_override("font_color", color_letra)
	queue_redraw()   # pide a Godot que llame a _draw()


func _process(delta: float) -> void:
	position.y += speed * delta


## Godot llama a esta función para dibujar el nodo (debajo de sus hijos, como el Label).
func _draw() -> void:
	var color = mi_color()
	if anti:
		# Antiquark: anillo de color + barra encima de la letra (como ū, d̄)
		draw_circle(Vector2.ZERO, RADIO, FONDO_ANTI)
		draw_arc(Vector2.ZERO, RADIO - 1.5, 0, TAU, 32, color, 3.0, true)
		draw_line(Vector2(-4, -10), Vector2(4, -10), color, 2.0, true)
	else:
		# Quark: círculo relleno
		draw_circle(Vector2.ZERO, RADIO, color)


func mi_color() -> Color:
	return COLORES.get(type, Color.WHITE)


## Texto para mostrar en el HUD, ej. "u" o "anti-d"
func simbolo() -> String:
	return ("anti-" if anti else "") + type


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
