extends RichTextLabel

# This change the value the time will be displayed, but will not affect the Timer
# Ex: if change = 10, the UI will change every 10 seconds
@export var change = 0

func _ready():
	# Makes that change cannot be negative and if the value is default it'll change to 1
	if change <= 0:
		change = 1
	pass

func _process(delta):
	changeTimeText()
	pass

func changeTimeText():
	# Every "change" seconds the UI change
	if GameTime.minute % change == 0:
		clear()
		if GameTime.hour < 10 and GameTime.minute < 10:
			add_text("0" + str(GameTime.hour) + ":0" + str(GameTime.minute))
		elif GameTime.hour < 10 and GameTime.minute >= 10:
			add_text("0" + str(GameTime.hour) + ":" + str(GameTime.minute))
		elif GameTime.hour >= 10 and GameTime.minute < 10:
			add_text("" + str(GameTime.hour) + ":0" + str(GameTime.minute))
		elif GameTime.hour >= 10 and GameTime.minute >= 10:
			add_text("" + str(GameTime.hour) + ":" + str(GameTime.minute))
	pass
