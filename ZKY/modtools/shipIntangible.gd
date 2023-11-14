extends CheckButton

var ship

func _ready():
	add_to_group("ZKYTools")
	connect("toggled", self, "_on_button_toggled")


func setShip(s):
	ship = s


func _on_button_toggled(value):
	if value:
		ship.disableCollisionsOn(ship)
	else:
		ship.enableCollisions()

