extends Area2D

class_name InteractPlayer

@onready var player : CharacterBody2D = get_node("/root/Main/Player")

# Private var to check if player is in range, is being used to prevent errors
var _checkPlayer : int


# Player had interacted at some point with this?
var hadInteracted : bool

# Is player at the interaction range?
var isInInteractionRange : bool

# Is player trying to interact with the object?
var isInteracting : bool

func _process(delta):
	pass

func handlePlayerInteraction():
	var nodes = get_overlapping_bodies()
	for N in nodes.size():
		if "Player" in nodes[N].name:
			_checkPlayer += 1
			if Input.is_action_just_pressed("Interact"):
				hadInteracted = true
				isInteracting = true
			else:
				isInteracting = false
	
	if _checkPlayer > 0:
		isInInteractionRange = true
	else:
		isInInteractionRange = false
	_checkPlayer = 0
	pass
