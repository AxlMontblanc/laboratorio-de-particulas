extends Area2D
@export var speed = 100
@export var type = "u"
# Creating two groups of quarks according to their charge
const pquarks = ["u", "c", "t"]
const nquarks = ["d", "s", "b"]
var charge : float = 0.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.text = type
	if (type in pquarks):
		charge = 2.0/3.0
	elif (type in nquarks):
		charge = -1.0/3.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
