extends "res://hud/SystemMineralList.gd"

func _ready():
	if Settings.ZKYConfig["additions"]["addMinerals"]:
		self.rect_scale = Vector2(.85, .85)


func toggleColumn(m):
	Debug.l(str(m, " pressed, toggling all"))

	var idx = minerals.find(m)
	var count = get_child_count()

	for nr in range(count):
		var n:Button = get_child(nr)
		var column = (nr % columns) == idx+1
		if column and !n.disabled:
			n.pressed = !n.pressed
