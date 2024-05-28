extends "res://hud/SystemMineralList.gd"


#Quick and dirty fix to prevent geologist tuning from spilling off the side
func _ready():
	self.rect_scale = Vector2(.85, .85)


#Toggles the mineral selection of every equipment
func toggleColumn(m):
	#Get the inex of the mineral toggled
	var idx = minerals.find(m) + 1
	#Get how many child nodes we have
	var count = get_child_count()
	#Get the state of the first filter button for that mineral
	var val = get_child(idx + columns).pressed

	#For evey child node
	for nr in range(count):
		#Get the node
		var n:Button = get_child(nr)
		#Check if the node is in the correct column
		var column = (nr % columns) == idx
		#If it is, and is not disabled
		if column and !n.disabled:
			#Set it to the opposite of the value
			n.pressed = !val
