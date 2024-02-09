extends MarginContainer

@onready var label : Label = $MarginContainer/Label
@onready var timer : Timer = $LetterDisplayTimer

const MAX_WIDTH = 256

var text := ""
var letterIndex := 0

var initLetterTime : float
var initSpaceTime : float
var initPunctuationTime : float

@export_category("Time")
@export var letterTime = 0.06
@export var spaceTime = 0.12
@export var punctuationTime = 0.4

var finishedDisplaying := false

var spriteHeight := 0.0

func _ready():
	initLetterTime = letterTime
	initSpaceTime = spaceTime
	initPunctuationTime = punctuationTime
	pass

func _process(delta):
	pass

func displayText(textToDisplay : String):
	text = textToDisplay
	label.text = text
	await resized
	custom_minimum_size.x = min(size.x, MAX_WIDTH)
	if size.x > MAX_WIDTH:
		label.autowrap_mode = TextServer.AUTOWRAP_WORD # go to a new line
		await resized # wait for x resize
		await resized # wait for y resize
	custom_minimum_size.y = size.y
	global_position.x -= size.x / 2
	global_position.y -= size.y + spriteHeight
	label.text = ""
	displayLetter()
	pass

func displayLetter():
	label.text += text[letterIndex]
	letterIndex += 1
	if letterIndex >= text.length():
		finishedDisplaying = true
		return
	
	# Each group of character will take a different time to display another letter
	match text[letterIndex]:
		",", ".", "?", "!":
			timer.start(punctuationTime)
		" ":
			timer.start(spaceTime)
		_:
			timer.start(letterTime)

func textSpeed(speed : float):
	letterTime = initLetterTime / speed
	spaceTime = initSpaceTime / speed
	punctuationTime = initPunctuationTime / speed

func _on_letter_display_timer_timeout():
	displayLetter()
	pass # Replace with function body.
