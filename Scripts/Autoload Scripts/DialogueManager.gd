extends Node

@onready var textBoxScene = preload("res://Scenes/TextBox.tscn")
@onready var dialogButtonScene = preload("res://Scenes/DialogButton.tscn")

var dialogLines : Array[String] = []
var currentLineIndex := 0 # to show lines at different moments
var isDialogActive := false
var canAdvanceLine := false

var textBox : MarginContainer
var textBoxPosition : Vector2
var textBoxSpriteHeight
var hasTextBox := false

var dialogButton : Array[MarginContainer] = []
var hasOptions := false
var option := 0
var optionName : Array[String] = []
var choosedOption := -1

func _process(delta):
	handleInput()
	if hasTextBox and hasOptions and canAdvanceLine:
		adjustOptionsPosition()
		waitForChoice()
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
	if hasOptions:
		for N in dialogButton.size():
			dialogButton[N].queue_free()
			hasOptions = false
			option = 0
			optionName.clear()
			choosedOption = -1
		dialogButton.clear()
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
	
	checkIfHasOptions()
	if hasOptions:
		createOptions()
	
	canAdvanceLine = false
	pass

func handleInput():
	if hasOptions:
		waitForChoice()
	if Input.is_action_just_pressed("AdvanceDialogue") and isDialogActive and canAdvanceLine and not hasOptions:
		textBox.queue_free()
		hasTextBox = false
		currentLineIndex += 1
		if currentLineIndex >= dialogLines.size():
			isDialogActive = false
			currentLineIndex = 0
			return
		showTextBox()

func changeTextSpeed():
	if Input.is_action_pressed("AdvanceDialogue") and isDialogActive and hasTextBox:
		textBox.textSpeed(8)
	elif not Input.is_action_pressed("AdvanceDialogue") and isDialogActive and hasTextBox:
		textBox.textSpeed(1)

func checkIfHasOptions():
	var nextPos = currentLineIndex + 1
	if nextPos < dialogLines.size():
		if "Choose 1" in dialogLines[nextPos]:
			option = 1
		elif "Choose 2" in dialogLines[nextPos]:
			option = 2
		elif "Choose 3" in dialogLines[nextPos]:
			option = 3
		elif "Choose 4" in dialogLines[nextPos]:
			option = 4
		else:
			option = 0
		
		if option == 0:
			hasOptions = false
			return
		else:
			hasOptions = true
	
	var index := 0
	
	match option:
		1:
			for N in option:
				optionName.append(dialogLines[nextPos + N + 1])
				index += 1
		2:
			for N in option:
				optionName.append(dialogLines[nextPos + N + 1])
				index += 1
		3:
			for N in option:
				optionName.append(dialogLines[nextPos + N + 1])
				index += 1
		4:
			for N in option:
				optionName.append(dialogLines[nextPos + N + 1])
				index += 1

func createOptions():
	for N in option:
			var id = N + 1
			dialogButton.append(dialogButtonScene.instantiate())
			get_tree().root.get_node("Main").add_child(dialogButton[N])
			dialogButton[N].setButton(optionName[N], id)
			dialogButton[N].visible = false

func adjustOptionsPosition():
	for N in option:
		dialogButton[N].visible = true
		if N == 0:
			dialogButton[N].global_position.x = textBox.global_position.x
			dialogButton[N].global_position.y = textBox.global_position.y + textBox.size.y
		else:
			dialogButton[N].global_position.x = dialogButton[N - 1].global_position.x
			dialogButton[N].global_position.y = dialogButton[N - 1].global_position.y + dialogButton[N - 1].size.y

func waitForChoice():
	for N in option:
		if dialogButton[N].choosed:
			choosedOption = dialogButton[N].id
			break
	pass

func getAnswer() -> int:
	if choosedOption > 0:
		return choosedOption
	else:
		return -1
