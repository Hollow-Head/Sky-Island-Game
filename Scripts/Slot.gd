extends PanelContainer

var description : String

@onready var selfIcon : TextureRect = $Item
@onready var iconTexture : TextureRect = get_parent().get_parent().get_node("Details").get_node("Picture").get_node("Icon")
@onready var descriptionText : Label = get_parent().get_parent().get_node("Details").get_node("Description").get_node("Text")

var fullDescription : String

func _ready():
	fullDescription = "Name: " + name + "\n" + "Description: " + "\n" + description
	pass

func _on_mouse_entered():
	if selfIcon.texture:
		iconTexture.texture = selfIcon.texture
	else:
		printerr("NO TEXTURE")
	descriptionText.text = fullDescription
	pass

func _on_mouse_exited():
	iconTexture.texture = null
	descriptionText.text = ""
