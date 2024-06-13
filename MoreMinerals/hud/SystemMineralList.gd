extends "res://hud/SystemMineralList.gd"


#Quick and dirty fix to prevent geologist tuning from spilling off the side
func _ready():
	self.rect_scale = Vector2(.8, .8)


#Toggles the mineral selection of every equipment
func toggleColumn(m):
#	Get the inex of the mineral toggled
	var idx = minerals.find(m) + 1
#	Get how many child nodes we have
	var count = get_child_count()
#	Get the state of the first filter button for that mineral
	var val = get_child(idx + columns).pressed

#	For evey child node
	for nr in range(count):
#	Get the node
		var n:Button = get_child(nr)
#	Check if the node is in the correct column
		var column = (nr % columns) == idx
#	If it is, and is not disabled
		if column and !n.disabled:
#		Set it to the opposite of the value
			n.pressed = !val


#Toggles all minerals for one equipment
func toggleRow(b):
	var rowStart = b.get_index()
#	The state that we will be setting the filters to
	var val = null
#	For the number of minerals there are plus H2O and UNMARKED
	for i in (CurrentGame.traceMinerals.size()+2):
#	Get the node
		var n:Button = get_child(rowStart+i+1)
#	if the button is not disabled
		if !n.disabled:
#		If the value has not been set yet
			if val == null:
#			Set the value
				val = n.pressed
#		Set the button to the opposite of the value
			n.pressed = !val



