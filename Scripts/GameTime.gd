extends Timer

#TODO MAKE A FUNC THAT MAKES TIME GO FAST TO A CERTAIN HOUR, MINUTE
#TODO INCREASE EXPONENTIALLY

@export_category("Time")
@export var initialMinute : int
@export var initialHour : int

var minute := 0
var hour := 0

var dawn : bool
var morning : bool
var afternoon : bool
var night : bool

func _ready():
	minute = initialMinute
	hour = initialHour
	start()
	pass

func _process(delta):
	# Dawn
	if hour >= 0 and hour <= 6:
		dawn = true
		morning = false
		afternoon = false
		night = false
	# Morning
	elif hour >= 6 and hour < 12:
		dawn = false
		morning = true
		afternoon = false
		night = false
	# Afternoon
	elif hour >= 12 and hour < 18:
		dawn = false
		morning = false
		afternoon = true
		night = false
	# Night
	elif hour >= 18 and hour <= 24:
		dawn = false
		morning = false
		afternoon = false
		night = true
	pass

func partOfDay() -> String:
	if dawn:
		return "Dawn"
	elif morning:
		return "Morning"
	elif afternoon:
		return "Afternoon"
	elif night:
		return "Night"
	else:
		return "Error In TIME!!! TIME IS COLLAPSING"

func _on_timeout():
	minute += 1
	if minute == 60:
		minute = 0
		hour += 1
	if hour == 24:
		hour = 0
	#print("Hora: " + str(hour) + " Minuto: " + str(minute))
	pass
