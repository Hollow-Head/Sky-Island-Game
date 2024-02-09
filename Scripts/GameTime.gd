extends Timer

#TODO change every variable to english

@export var minutoInicial : int
@export var horaInicial : int

var minuto := 0
var hora := 0

func _ready():
	minuto = minutoInicial
	hora = horaInicial
	start()
	pass

func _process(delta):
	pass

func _on_timeout():
	minuto += 1
	if minuto == 60:
		minuto = 0
		hora += 1
	if hora == 24:
		hora = 0
	#print("Hora: " + str(hora) + " Minuto: " + str(minuto))
	pass
