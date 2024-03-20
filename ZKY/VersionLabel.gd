extends "res://VersionLabel.gd"

func _ready():
	grow_horizontal = 0
	text = "ΔV %s + ZKY %s" % [text, Settings.ZKY_VERSION]
	CurrentGame.version = text
