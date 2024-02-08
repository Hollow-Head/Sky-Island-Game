extends Node

@onready var point : Marker2D = get_node("Point")
@onready var island : Sprite2D = get_node("Island")

var angle := 0.0

@export var clockwise := true
@export var radius := 400.0
@export var speed := 1
@export var startAngle := 0

# Called when the node enters the scene tree for the first time.
func _ready():
	angle -= deg_to_rad(startAngle)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	orbitRotation(delta)
	pass

func orbitRotation(delta : float):
	if clockwise:
		angle += delta
	else:
		angle -= delta
	island.global_position = Vector2(cos(angle * speed) * radius, 
									sin(angle * speed) * radius) + point.global_position
