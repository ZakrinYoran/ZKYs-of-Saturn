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
