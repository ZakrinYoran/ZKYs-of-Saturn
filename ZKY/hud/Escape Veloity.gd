extends "res://hud/Escape Veloity.gd"

func _ready():
	add_to_group("ZKYSettings")
	updateSettings()

func updateSettings():
	warnVelocity = float(Settings.ZKYConfig["gameTweaks"]["warningVelocity"])
