extends Node

const MOD_PRIORITY = -10

var _savedObjects = []

var modName : String = "MoreMinerals"
var modPath : String


#Initialize the mod
func _init(modLoader = ModLoader):
	Debug.l(modName + ": Initializing")

#	Get current path of script
	modPath = get_script().resource_path.get_base_dir() + "/"

#	Install our script extensions
	initAsteroids()
	initHUD()
	initShip()
	initElse()

	Debug.l(modName + ": Initialized")


func initAsteroids():
	installScriptExtension("asteroids/mineral.gd")
	installScriptExtension("AsteroidSpawner.gd")

func initHUD():
	installScriptExtension("hud/components/MineralLabel.gd")
	installScriptExtension("hud/SystemMineralList.gd")

func initShip():
	installScriptExtension("ships/modules/MineralProcessingUnit.gd")
	installScriptExtension("ships/ship-ctrl.gd")

func initElse():
	installScriptExtension("TheRing.gd")
	installScriptExtension("CurrentGame.gd")

	replaceScene("comms/conversation/HabitatConversation.tscn")


#Do stuff on ready 
func _ready():
#	Add our translations
	updateTL(modPath + "i18n/translation.txt", "|")

	Debug.l(modName + ": Ready")


# Helper script to load translations
func updateTL(csvPath:String, delim:String = ","):
	Debug.l("%s: Adding translations from: %s" % [modName, csvPath])
	var tlFile = File.new()
	tlFile.open(csvPath, File.READ)

	var translations = []

	var csvLine = tlFile.get_line().split(delim)
	Debug.l("Adding translations as: %s" % csvLine)
	for i in range(1, csvLine.size()):
		var translationObject = Translation.new()
		translationObject.locale = csvLine[i]
		translations.append(translationObject)

	while not tlFile.eof_reached():
		csvLine = tlFile.get_csv_line(delim)

		if csvLine.size() > 1:
			var translationID = csvLine[0]
			for i in range(1, csvLine.size()):
				translations[i - 1].add_message(translationID, csvLine[i].c_unescape())
			Debug.l("Added translation: %s" % csvLine)

	tlFile.close()

	for translationObject in translations:
		TranslationServer.add_translation(translationObject)

	Debug.l("%s: Translations Updated" % modName)


# Helper function to extend scripts
func installScriptExtension(path:String):
	var childPath = str(modPath + path)
	var childScript = ResourceLoader.load(childPath)

	childScript.new()

	var parentScript = childScript.get_base_script()
	var parentPath = parentScript.resource_path

	Debug.l("Installing script extension: %s <- %s" % [parentPath, childPath])

	childScript.take_over_path(parentPath)


# Helper function to replace scenes
func replaceScene(path:String, oldPath:String = "none"):
	Debug.l("Updating scene: %s" % path)
	var newScene
	var oldScene

	if oldPath == "none":
		newScene = str(modPath + path)
		oldScene = str("res://" + path)

	else:
		newScene = path
		oldScene = oldPath

	var scene = load(newScene)
	scene.take_over_path(oldScene)
	_savedObjects.append(scene)
	Debug.l("Finished updating: %s" % oldScene)
