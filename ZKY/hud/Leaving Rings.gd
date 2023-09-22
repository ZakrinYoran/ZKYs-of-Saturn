extends "res://hud/Leaving Rings.gd"

func _ready():
	if Settings.ZKYConfig["gameTweaks"]["disableMapBoundries"]:
		visible = false
