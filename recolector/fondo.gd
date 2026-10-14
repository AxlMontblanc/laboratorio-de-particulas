extends Node2D
## Fondo tipo detector de partículas: fondo oscuro con anillos y líneas tenues,
## como un corte transversal de un detector (ej. CMS o ATLAS).

const COLOR_FONDO = Color(0.04, 0.05, 0.11)
const COLOR_LINEAS = Color(0.3, 0.5, 0.9, 0.12)


func _ready() -> void:
	# Si cambia el tamaño de la ventana, volver a dibujar
	get_viewport().size_changed.connect(queue_redraw)


func _draw() -> void:
	var tam = get_viewport_rect().size
	draw_rect(Rect2(Vector2.ZERO, tam), COLOR_FONDO)

	# Centro del "detector": abajo al centro, donde está el colector
	var centro = Vector2(tam.x / 2, tam.y)
	for i in range(1, 9):
		draw_arc(centro, i * 90.0, PI, TAU, 96, COLOR_LINEAS, 2.0, true)
	for i in range(13):
		var angulo = PI + i * PI / 12
		draw_line(centro, centro + Vector2.from_angle(angulo) * 800, COLOR_LINEAS, 1.0, true)
