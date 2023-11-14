extends "res://TheRing.gd"


onready var baseOddities = odditiesEvery
onready var baseDiggers = diggerEvery


func _ready():
	add_to_group("ZKYSettings")
	updateSettings()


func updateSettings():
	odditiesEvery = baseOddities / Settings.ZKYConfig["eventTweaks"]["oddityAdjust"]
	diggerEvery = baseDiggers / Settings.ZKYConfig["eventTweaks"]["diggerAdjust"]

	if Settings.ZKYConfig["modTesting"]["testEvent"]:
		testSpecificStoryElement = Settings.ZKYConfig["modTesting"]["testEvent"]


func spawnSpecificEvent(id):
	Debug.l("ZKY: Attempting forced spawn of %s " % id)
	var pos = CurrentGame.getPlayerShip().global_position
	var pick = get_node(id)

	if pick == null:
		Debug.l("ZKY: ERR NO SUCH EVENT")
		return null

	var oddity = pick.makeAt(pos)
	if oddity:
#		addNearbyOddity(id, oddity, pos)
		if oddity is Array:
			for o in oddity:
				o.connect("tree_entered", self, "oddityConfirmed", [randomOddityKey])
		else :
			oddity.connect("tree_entered", self, "oddityConfirmed", [randomOddityKey])
		unspawnedOddities[randomOddityKey] = oddity
