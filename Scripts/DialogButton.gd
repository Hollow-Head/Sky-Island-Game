extends MarginContainer

@onready var label : Label = $MarginContainer/Label

var choosed := false
var id : int
#var nomezinho := "CAMILA"
var initScale : Vector2

func _ready():
	initScale = scale
	pass

func _process(delta):
	pass

func setButton(Name : String, ID : int):
	label.text = Name
	id = ID

func _on_button_pressed():
	choosed = true
	pass


func _on_button_mouse_entered():
	scale.x = initScale.x * 1.15
	pass


func _on_button_mouse_exited():
	scale.x = initScale.x
	pass
