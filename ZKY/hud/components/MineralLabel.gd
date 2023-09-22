extends "res://hud/components/MineralLabel.gd"

func _ready():
	self.connect("pressed", get_parent(), "toggleColumn", [mineral])

