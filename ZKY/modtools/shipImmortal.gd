extends CheckButton

var ship

func _ready():
	add_to_group("ZKYTools")
	connect("visibility_changed", self, "_on_visibility_changed")
	connect("toggled", self, "_on_button_toggled")


func _on_button_toggled(value):
	if value:
		ship.invunerability = INF
	else:
		ship.invunerability = 0


func _on_visibility_changed():
	pressed = ship.invunerability


func setShip(s):
	ship = s
