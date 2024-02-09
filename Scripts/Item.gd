extends InteractPlayer

func _ready():
	pass

func _process(delta):
	handlePlayerInteraction()
	if isInteracting:
		print("Plim Plim")
	pass
