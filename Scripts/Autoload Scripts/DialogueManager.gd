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

func startDialog(position : Vector2, lines : Array[String], height : float):
	if isDialogActive:
		return
	
	dialogLines = lines
	textBoxPosition = position
	textBoxSpriteHeight = height
	
	showTextBox()
	isDialogActive = true

func showTextBox():
	hasTextBox = true
	textBox = textBoxScene.instantiate()
	get_tree().root.get_node("Main").add_child(textBox) #PAY ATTENTION
	textBox.global_position = textBoxPosition
	textBox.spriteHeight = textBoxSpriteHeight
	textBox.displayText(dialogLines[currentLineIndex])
	canAdvanceLine = false
	pass

func _unhandled_input(event):
	if hasTextBox:
		if textBox.finishedDisplaying:
			canAdvanceLine = true
			pass
	
	if event.is_action_pressed("AdvanceDialogue") and isDialogActive and canAdvanceLine:
		textBox.queue_free()
		hasTextBox = false
		currentLineIndex += 1
		if currentLineIndex >= dialogLines.size():
			isDialogActive = false
			currentLineIndex = 0
			return
		showTextBox()
