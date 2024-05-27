extends "res://hud/SystemMineralList.gd"

#Quick and dirty fix to prevent geologist tuning from spilling off the side
func _ready():
	self.rect_scale = Vector2(.85, .85)
