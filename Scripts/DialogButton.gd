extends MarginContainer

@onready var label : Label = $MarginContainer/Label

var choosed := false
var id : int
#var nomezinho := "CAMILA"

func _ready():
	pass

func _process(delta):
	pass

func setButton(Name : String, ID : int):
	label.text = Name
	id = ID

func _on_button_pressed():
	choosed = true
	pass
