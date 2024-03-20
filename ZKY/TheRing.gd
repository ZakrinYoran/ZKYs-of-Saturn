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


func getVeinAt(pos)->String:
	if Settings.ZKYConfig["additions"]["addMinerals"]:
		var p1 = getVeinPixelAt(pos / 1861.0)
		var p2 = getVeinPixelAt(pos / - 2531.0)
		var p3 = getVeinPixelAt(pos / 1337.0)

		var values = [p1.r, p1.g, p1.b, p1.a, p2.r, p2.b, p2.g, p2.a, p3.r, p3.b, p3.g, p3.a]

		var total = 0
		for n in range(CurrentGame.traceMinerals.size()):
			var tm = CurrentGame.traceMinerals[n]
			values[n] = pow(values[n] / pow(CurrentGame.mineralPrices.get(tm, 1), 0.2), 4)
			total += values[n]

		var rnd = randf() * total
		var nr = 0
		for n in values:
			rnd -= n
			if rnd < 0:
				return CurrentGame.traceMinerals[nr]
			nr += 1

		return CurrentGame.traceMinerals[0]
	else:
		return .getVeinAt(pos)
