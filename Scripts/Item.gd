extends InteractPlayer

@onready var letterE = $LetterE
@onready var sprite : Sprite2D = $Sprite2D
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

func print2Darray(array : Array):
	for N in array.size():
		for M in array[N].size():
			print(array[N][M])

func _on_body_exited(body):
	# Probably will bug if player is really close to another interaction range
	if "Player" in body.name:
		DialogueManager.endDialog()
