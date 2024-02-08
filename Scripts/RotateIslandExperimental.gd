extends Node

# https://www.youtube.com/watch?v=2Ywhk_T85Vg got help with this

@onready var point : Marker2D = get_node("Point")
@onready var island : Sprite2D = get_node("Island")

var translationAngle := 0.0

@export var translationClockwise := true
@export var radius := 400.0
@export var translationSpeed := 1.0
@export var translationStartAngle := 0

var rotationAngle := 0.0

@export var rotationClockwise := true
@export var rotationSpeed := 1.0
@export var rotationStartAngle := 0

func _ready():
	translationAngle -= deg_to_rad(translationStartAngle)
	rotationAngle -= deg_to_rad(rotationStartAngle)
	pass

func _process(delta):
	orbitTranslation(delta)
	orbitRotation(delta)
	pass

func orbitTranslation(delta : float):
	if translationClockwise:
		translationAngle += delta
	else:
		translationAngle -= delta
	island.global_position = Vector2(cos(translationAngle * translationSpeed) * radius, 
									sin(translationAngle * translationSpeed) * radius) + point.global_position

func orbitRotation(delta : float):
	if rotationClockwise:
		rotationAngle += delta
	else:
		rotationAngle -= delta
	island.global_rotation = rotationAngle * rotationSpeed
	pass
