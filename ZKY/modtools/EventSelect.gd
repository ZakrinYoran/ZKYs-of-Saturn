extends OptionButton

var baseText ="SETTINGS_EVENT_SELECT"
var events = []
var ship

func _ready():
	add_to_group("ZKYTools")
	fillInEvents()


func setShip(s):
	ship = s


func fillInEvents():
	clear()
	add_item(baseText)
	var curr = Loader.current
	if curr.name == "Game":
		var ring = curr.get_node("TheRing")
#		events = ring.getEventsPossibleAt(ship.global_position)
		events = ring.getAllPossibleEvents()
		for event in events:
			add_item(event)


func _on_EventSpawn_pressed():
	var curr = Loader.current
	if curr.name == "Game":
		var ring = curr.get_node("TheRing")
		ring.spawnSpecificEvent(text)
