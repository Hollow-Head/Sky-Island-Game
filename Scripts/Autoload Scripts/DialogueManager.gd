extends Node

@onready var textBoxScene = preload("res://Scenes/TextBox.tscn")

var dialogLines : Array[String] = []
var currentLineIndex := 0 # to show lines at different moments

var textBox
var textBoxPosition : Vector2
var textBoxSpriteHeight

var isDialogActive := false
var canAdvanceLine := false

var hasTextBox := false

func _process(delta):
	# Check if there's a textBox and if it have finished displaying the text
	if hasTextBox:
		if textBox.finishedDisplaying:
			canAdvanceLine = true
	changeTextSpeed()

func startDialog(position : Vector2, lines : Array[String], height : float):
	# If there's a dialogue active, the function will not go by
	if isDialogActive:
		return
	
	dialogLines = lines
	textBoxPosition = position
	textBoxSpriteHeight = height
	
	showTextBox()

func endDialog():
	if hasTextBox:
		textBox.queue_free()
		hasTextBox = false
	currentLineIndex = 0
	isDialogActive = false
	canAdvanceLine = false
	pass

func showTextBox():
	isDialogActive = true
	hasTextBox = true
	
	# create a new TextBox with the variables acquired in StartDialog
	textBox = textBoxScene.instantiate()
	get_tree().root.get_node("Main").add_child(textBox) #PAY ATTENTION
	textBox.global_position = textBoxPosition
	textBox.spriteHeight = textBoxSpriteHeight
	textBox.displayText(dialogLines[currentLineIndex])
	
	canAdvanceLine = false
	pass

func _unhandled_input(event):
	if event.is_action_pressed("AdvanceDialogue") and isDialogActive and canAdvanceLine:
		textBox.queue_free()
		hasTextBox = false
		currentLineIndex += 1
		if currentLineIndex >= dialogLines.size():
			isDialogActive = false
			currentLineIndex = 0
			return
		showTextBox()

#ATTENTION
func changeTextSpeed():
	if Input.is_action_pressed("AdvanceDialogue") and isDialogActive and hasTextBox:
		textBox.textSpeed(8)
		#print("speed")
	elif not Input.is_action_pressed("AdvanceDialogue") and isDialogActive and hasTextBox:
		textBox.textSpeed(1)
		#print("not speed")
