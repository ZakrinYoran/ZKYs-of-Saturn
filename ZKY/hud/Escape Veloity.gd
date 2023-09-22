extends "res://hud/Escape Veloity.gd"

func _ready():
	warnVelocity = float(Settings.ZKYConfig["gameTweaks"]["escapeVelocityWarning"])
