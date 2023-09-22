extends "res://TheRing.gd"


func _ready():
	odditiesEvery /= Settings.ZKYConfig["eventTweaks"]["oddityAdjust"]
	diggerEvery /= Settings.ZKYConfig["eventTweaks"]["diggerAdjust"]
	if Settings.ZKYConfig["modTesting"]["testEvent"]:
		testSpecificStoryElement = Settings.ZKYConfig["modTesting"]["testEvent"]
