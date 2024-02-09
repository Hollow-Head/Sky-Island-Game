extends InteractPlayer

@onready var letterE = $LetterE
@onready var sprite : Sprite2D = $Sprite2D

const lines: Array[String] = [
	"Well well well, looks like I'm a speaking key!",
	"I wish I was a pig with wings! Or a president.",
	"Maybe both..."
]

func _ready():
	pass

func _process(delta):
	handlePlayerInteraction()
	# Just for test, change later, pls
	if isInInteractionRange:
		letterE.visible = true
	else:
		letterE.visible = false
	if isInteracting:
		# You can advance dialog with "mouse left"
		DialogueManager.startDialog(sprite.global_position, lines, 100)
	pass
