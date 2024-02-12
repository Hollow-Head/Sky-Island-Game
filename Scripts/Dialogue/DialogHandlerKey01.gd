extends Node

@onready var item = get_parent()
@onready var sprite = get_parent().get_node("Sprite2D")
@onready var dialogText = $DialogText

var answer : int

enum choose01 {PRESIDENT = 1, PIG_WITH_WINGS = 2}
var hasAnswered01 : bool

enum choose02 {YES = 1, NO = 2, LETICIA = 3}
var hasAnswered02 : bool

func handleDialog():
	if item.isInteracting:
		# You can advance dialog with "mouse left"
		if not hasAnswered01:
			DialogueManager.startDialog(sprite.global_position, dialogText.text01, 100)
		elif not hasAnswered02:
			DialogueManager.startDialog(sprite.global_position, dialogText.text05, 100)
		# This dialogue will only happen at night
		elif GameTime.night:
			DialogueManager.startDialog(sprite.global_position, dialogText.text09, 100)
		else:
			DialogueManager.startDialog(sprite.global_position, dialogText.text04, 100)

	if DialogueManager.getAnswer() > 0:
		answer = DialogueManager.getAnswer()
		DialogueManager.endDialog()
		
		if not hasAnswered01:
			if answer == choose01.PRESIDENT:
				DialogueManager.startDialog(sprite.global_position, dialogText.text03, 100)
				finalizeAnswer01()
			elif answer == choose01.PIG_WITH_WINGS:
				DialogueManager.startDialog(sprite.global_position, dialogText.text02, 100)
				finalizeAnswer01()
		if not hasAnswered02:
			if answer == choose02.YES:
				DialogueManager.startDialog(sprite.global_position, dialogText.text06, 100)
				finalizeAnswer02()
			elif answer == choose02.NO:
				DialogueManager.startDialog(sprite.global_position, dialogText.text07, 100)
				finalizeAnswer02()
			elif answer == choose02.LETICIA:
				DialogueManager.startDialog(sprite.global_position, dialogText.text08, 100)
				finalizeAnswer02()

func finalizeAnswer01():
	answer = -1
	hasAnswered01 = true

func finalizeAnswer02():
	answer = -1
	hasAnswered02 = true
