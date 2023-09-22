extends "res://VersionLabel.gd"

func _ready():
	grow_horizontal = 0
	text = text + " + ZKY %s" % Settings.ZKY_VERSION
	CurrentGame.version = text
