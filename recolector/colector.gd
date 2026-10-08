extends Area2D
@export var speed = 400
@export var width = 120
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var axis = Input.get_axis("ui_left", "ui_right")
	position.x += speed * delta * axis
	position.x = clamp(position.x, width/2, get_viewport_rect().size.x - (width/2))
	
	
func _on_area_entered(area: Area2D) -> void:
	print("lo atrape")
	area.queue_free() # Replace with function body.
