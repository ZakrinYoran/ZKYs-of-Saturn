extends Node

var _savedObjects = []


func _init(modLoader = ModLoader):
	Debug.l("DroneOCP: Initializing")

	modLoader.installScriptExtension("res://DroneOCP/CurrentGame.gd")
	modLoader.installScriptExtension("res://DroneOCP/ships/Shipyard.gd")

	updateTL()

	Debug.l("DroneOCP: Initialized")


func _ready():
	Debug.l("DroneOCP: Readying")

	updateUpgrades()

	Debug.l("DroneOCP: Ready")


# Why
func updateTL():
	Debug.l("DroneOCP: Updating Translations")

	var tlFile = File.new()
	tlFile.open("res://DroneOCP/i18na/translation.txt", File.READ)

	var translation = Translation.new()
	translation.locale = "en"

	while tlFile.get_position() < tlFile.get_len():
		var line = tlFile.get_line()
		var split = line.split("|", false)
		if split.size() == 2:
			translation.add_message(split[0], tr(split[1]).c_unescape())
			Debug.l(str("Added translation: ", split))

	TranslationServer.add_translation(translation)

	Debug.l("DroneOCP: Translations Updated")


func updateUpgrades():
	replaceScene("res://DroneOCP/enceladus/Upgrades.tscn", "res://enceladus/Upgrades.tscn")


func replaceScene(newScene:String, oldScene:String):
	Debug.l("Updating scene: %s" % oldScene)
	var scene = load(newScene)
	scene.take_over_path(oldScene)
	_savedObjects.append(scene)
	Debug.l("Finished updating: %s" % oldScene)
