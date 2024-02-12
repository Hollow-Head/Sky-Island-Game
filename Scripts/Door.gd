extends InteractPlayer

@onready var letterE = $LetterE
@onready var dialogHandler = $DialogHandler

func _ready():
	pass

func _process(delta):
	handlePlayerInteraction()
	dialogHandler.handleDialog()
	
	# Just for test, change later, pls
	if isInInteractionRange:
		letterE.visible = true
	else:
		letterE.visible = false
	pass


func _on_body_exited(body):
	if "Player" in body.name:
		DialogueManager.endDialog()
	pass
