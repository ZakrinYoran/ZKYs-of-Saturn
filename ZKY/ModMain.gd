extends Node

# Stupid mod priority because it is very sensitive to the order things are loaded
const MOD_PRIORITY = -100

var _savedObjects = []

var modConfig = {}

func _init(modLoader = ModLoader):
	Debug.l("ZKY: Initializing")

# Modify Settings.gd first so we can load config and DLC
	installScriptExtension("Settings.gd")
	loadSettings()

# Must load DLC early for it to function.
	if modConfig["modSettings"]["loadDLC"]:
		loadDLC()

# WIP, does not work
#	installScriptExtension("Music.gd")

# Scenes that use placeholders must be loaded as soon as possible
	if modConfig["additions"]["addEquipment"]:
		replaceScene("weapons/WeaponSlot.tscn")

# Also uses placeholders
	if modConfig["sillyStuff"]["addATK222222225"]:
		replaceScene("res://ZKY/silly/K222222225/hud/AT222222225-Hud.tscn", "res://hud/Hud.tscn")

# Modify the version so it's painfully obvious that the game is modded
	if modConfig["modSettings"]["updateVersion"]:
		installScriptExtension("VersionLabel.gd")

	installScriptExtension("CurrentGame.gd")
	installScriptExtension("TheRing.gd")

# Must be loaded before Shipyard.gd
	installScriptExtension("ships/ship-ctrl.gd")

	if modConfig["additions"]["addMinerals"]:
		installScriptExtension("AsteroidSpawner.gd")

# Must be loaded before Shipyard.gd
	if modConfig["cargoTweaks"]["canDumpProcessed"]:
		installScriptExtension("ships/modules/MineralProcessingUnit.gd")

	if modConfig["gameTweaks"]["escapeVelocityWarning"] != 150:
		installScriptExtension("hud/Escape Veloity.gd")

	if modConfig["gameTweaks"]["disableMapBoundries"]:
		installScriptExtension("hud/Leaving Rings.gd")

	if modConfig["cargoTweaks"]["canToggleColumn"]:
		installScriptExtension("hud/components/MineralLabel.gd")

	installScriptExtension("hud/SystemMineralList.gd")

# Loads ship .tscn files which binds anything related, not giving us a chance to replace them.
	installScriptExtension("ships/Shipyard.gd")

	if modConfig["modSettings"]["loadTL"]:
		updateTL() #Load custom translations

	Debug.l("ZKY: Initialized")


func _ready():
	Debug.l("ZKY: Readying")

	updateUpgrades()

	if modConfig["additions"]["addMinerals"] and modConfig["additions"]["addEvents"]:
		replaceScene("comms/conversation/HabitatConversation.tscn")

	if modConfig["additions"]["addEvents"]:
		replaceScene("story/TheRing.tscn")

# WIP, will not work with remote processed cargo sources
	if modConfig["cargoTweaks"]["canKeepProcessed"]:
		replaceScene("enceladus/DiveSummary.tscn")

	Debug.l("ZKY: Ready")


# Things that modify enceladus/Upgrades.tscn
func updateUpgrades():
	if modConfig["additions"]["addEquipment"]:
		replaceScene("enceladus/Upgrades.tscn")

	if modConfig["sillyStuff"]["addATK222222225"]:
		replaceScene("res://ZKY/silly/K222222225/enceladus/Upgrades.tscn", "res://enceladus/Upgrades.tscn")

	if modConfig["sillyStuff"]["addATK225-HH"]:
		replaceScene("res://ZKY/silly/K225-HH/enceladus/Upgrades.tscn", "res://enceladus/Upgrades.tscn")


# Instances Settings.gd early so we can load mod setting from the config file
func loadSettings():
	Debug.l("ZKY: Loading mod settings")
	var settings = load("res://Settings.gd").new()
	settings.loadZKYFromFile()
	settings.saveZKYToFile()
	modConfig = settings.ZKYConfig
	Debug.l("ZKY: Current settings: %s" % modConfig)
	settings.queue_free()
	Debug.l("ZKY: Finished loading settings")


# Helper script to load translations, as the ModLoader one seemingly does not function
func updateTL():
	Debug.l("ZKY: Updating Translations")

	var tlFile = File.new()
	tlFile.open("res://ZKY/i18na/translation.txt", File.READ)

	var translation = Translation.new()
	translation.locale = "en"

	while tlFile.get_position() < tlFile.get_len():
		var line = tlFile.get_line()
		var split = line.split("|", false)
		if split.size() == 2:
			translation.add_message(split[0], tr(split[1]).c_unescape())
			Debug.l(str("Added translation: ", split))

	TranslationServer.add_translation(translation)

	Debug.l("ZKY: Translations Updated")


# Instances Settings.gd, loads DLC, then frees the script.
func loadDLC():
	Debug.l("ZKY: Preloading DLC as workaround")
	var DLCLoader = load("res://Settings.gd").new()
	DLCLoader.loadDLC()
	DLCLoader.queue_free()
	Debug.l("ZKY: Finished loading DLC")


# Helper function to replace scenes
func replaceScene(path:String, oldPath:String = "none"):
	Debug.l("Updating scene: %s" % path)
	var newScene
	var oldScene

	if oldPath == "none":
		newScene = str("res://ZKY/" + path)
		oldScene = str("res://" + path)

	else:
		newScene = path
		oldScene = oldPath

	var scene = load(newScene)
	scene.take_over_path(oldScene)
	_savedObjects.append(scene)
	Debug.l("Finished updating: %s" % oldScene)


# Helper function to extend scripts
func installScriptExtension(path:String , oldPath:String = "none"):
	var childPath
	var parentPath

	if oldPath == "none":
		childPath = str("res://ZKY/" + path)
		parentPath = str("res://" + path)

	else:
		childPath = path
		parentPath = oldPath

	Debug.l("Installing script extension: %s <- %s" % [parentPath, childPath])

	var childScript = load(childPath)
	childScript.new()
	childScript.take_over_path(parentPath)
   
