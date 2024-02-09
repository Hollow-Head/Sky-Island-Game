extends Node

# https://www.youtube.com/watch?v=2Ywhk_T85Vg got help with this

var translationAngle := 0.0
var rotationAngle := 0.0

@onready var point : Marker2D = get_node("Point")
@onready var island : Sprite2D = get_node("Island")

@export_category("Island Rotation")

@export_group("Translation")
@export var Clockwise := true
@export var radius := 400.0
@export var Speed := 1.0
@export_range(-360, 360) var StartAngle := 0

@export_group("Rotation")
@export var clockwise := true
@export var speed := 1.0
@export_range(-360, 360) var startAngle := 0

func _ready():
	initAngle()
	pass

func _process(delta):
	orbitTranslation(delta)
	orbitRotation(delta)
	pass

func initAngle():
	translationAngle -= deg_to_rad(StartAngle)
	translationAngle -= deg_to_rad(StartAngle)

func orbitTranslation(delta : float):
	if Clockwise:
		translationAngle += delta
	else:
		translationAngle -= delta
	var childsNodes = get_children()
	
	# It'll translate everything in the scene, except the first node, which is the point, if u change, big mess
	for N in childsNodes.size():
		if N != 0:
			childsNodes[N].position = Vector2(cos(translationAngle * Speed) * radius, 
			sin(translationAngle * Speed) * radius) + point.position
		pass

func orbitRotation(delta : float):
	if clockwise:
		rotationAngle += delta
	else:
		rotationAngle -= delta
	
	# It'll rotate everything in the scene, except the first node, which is the point, if u change, big mess
	var childsNodes = get_children()
	for N in childsNodes.size():
		if N != 0:
			childsNodes[N].rotation = rotationAngle * speed
		pass
	pass
