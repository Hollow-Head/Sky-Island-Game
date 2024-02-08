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
	if time.minuto % change == 0:
		clear()
		if time.hora < 10 and time.minuto < 10:
			add_text("0" + str(time.hora) + ":0" + str(time.minuto))
		elif time.hora < 10 and time.minuto >= 10:
			add_text("0" + str(time.hora) + ":" + str(time.minuto))
		elif time.hora >= 10 and time.minuto < 10:
			add_text("" + str(time.hora) + ":0" + str(time.minuto))
		elif time.hora >= 10 and time.minuto >= 10:
			add_text("" + str(time.hora) + ":" + str(time.minuto))
	pass
