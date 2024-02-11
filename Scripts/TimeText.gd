extends RichTextLabel

# This change the value the time will be displayed, but will not affect the Timer
# Ex: if change = 10, the UI will change every 10 seconds
@export var change = 0

@onready var time : Timer = get_node("/root/Main/Game Time")

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
	if time.minute % change == 0:
		clear()
		if time.hour < 10 and time.minute < 10:
			add_text("0" + str(time.hour) + ":0" + str(time.minute))
		elif time.hour < 10 and time.minute >= 10:
			add_text("0" + str(time.hour) + ":" + str(time.minute))
		elif time.hour >= 10 and time.minute < 10:
			add_text("" + str(time.hour) + ":0" + str(time.minute))
		elif time.hour >= 10 and time.minute >= 10:
			add_text("" + str(time.hour) + ":" + str(time.minute))
	pass
