extends CheckButton

var ship

func _ready():
	add_to_group("ZKYTools")
	CurrentGame.connect("playerShipChanged", self, "setPlayerShip")
	connect("toggled", self, "_on_button_toggled")



func _on_button_toggled(value):
	ship._setCutscene(value)


func checkCutscene(val):
	pressed = val


func setShip(s):
	if ship:
		ship.disconnect()

	ship = s
	ship.connect("cutscene", self, "checkCutscene")
	pressed = ship.cutscene
