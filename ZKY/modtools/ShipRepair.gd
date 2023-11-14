extends Button

var ship

func _ready():
	add_to_group("ZKYTools")
	connect("pressed", self, "_on_button_pressed")


func setShip(s):
	ship = s


func _on_button_pressed():
	var systems = ship.getSystems()
	for sys in systems:
		var system = systems[sys]
		for d in system.damage:
			var total = d.current
			ship.changeSystemDamage(system.key, d.type, -total)
	ship.emit_signal("juryRigChanged")
