extends Node

@onready var item = get_parent()
@onready var sprite = get_parent().get_node("Sprite2D")
@onready var dialogText = $DialogText
@onready var playerzinho : CharacterBody2D = get_node("/root/Main/Player")

var isDoorOpened : bool

func handleDialog():
	if item.isInteracting:
		if not isDoorOpened:
			if GlobalInventory.hasKey01:
				#print("Tem a chave")
				DialogueManager.startDialog(sprite.global_position, dialogText.text02, 100)
				GlobalInventory.removeFromInventory("Key01")
				GlobalInventory.hasKey01 = false
				isDoorOpened = true
			else:
				DialogueManager.startDialog(sprite.global_position, dialogText.text01, 100)
				#print("Não tem a chave, vacilão demais, slc")
		else:
			DialogueManager.startDialog(sprite.global_position, dialogText.text03, 100)
