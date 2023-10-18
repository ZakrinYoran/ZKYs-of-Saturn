extends "res://hud/SystemList.gd"


func toggle(s, b):
	# If the player is holding the 'action_modifier' key, toggle all systems of the type pressed
	if Input.is_action_pressed("action_modifier"):
		var systems = ship.getSystems()
		for node in systems:
			if systems[node]["name"] == s.name:
				.toggle(systems[node], b)
	else:
		.toggle(s, b)
