extends "res://hud/Leaving Rings.gd"

func _ready():
	add_to_group("ZKYSettings")
	updateSettings()

func updateSettings():
	if Settings.ZKYConfig["gameTweaks"]["mapBoundries"]:
		visible = true
	else:
		visible = false
