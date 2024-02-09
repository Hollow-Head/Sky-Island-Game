extends MarginContainer

@onready var label : Label = $MarginContainer/Label
@onready var timer : Timer = $LetterDisplayTimer

const MAX_WIDTH = 256

var text := ""
var letterIndex := 0

var letterTime = 0.03
var spaceTime = 0.06
var punctuationTime = 0.2

var finishedDisplaying := false

var spriteHeight := 0.0

func _ready():
	pass

func _process(delta):
	pass

func displayText(textToDisplay : String):
	text = textToDisplay
	label.text = textToDisplay
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
	
	match text[letterIndex]:
		",", ".", "?", "!":
			timer.start(punctuationTime)
		" ":
			timer.start(spaceTime)
		_:
			timer.start(letterTime)


func _on_letter_display_timer_timeout():
	displayLetter()
	pass # Replace with function body.
