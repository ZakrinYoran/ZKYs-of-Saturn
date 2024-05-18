extends Node

const MOD_PRIORITY = 0

var _savedObjects = []

var modName : String = "MoreMinerals"
var modPath : String

#Initialize the mod
func _init(modLoader = ModLoader):
	Debug.l(modName + ": Initializing")

	# Get current path of script
	modPath = get_script().resource_path.get_base_dir() + "/"

	#Install our script extensions
	installScriptExtension("asteroids/mineral.gd")
	installScriptExtension("AsteroidSpawner.gd")
	installScriptExtension("ships/modules/MineralProcessingUnit.gd")
	installScriptExtension("ships/ship-ctrl.gd")
	installScriptExtension("TheRing.gd")
	installScriptExtension("CurrentGame.gd")

	replaceScene("comms/conversation/HabitatConversation.tscn")

	updateTL()

	Debug.l(modName + ": Initialized")


#Don't got nothin to do on ready
func _ready():
	Debug.l(modName + ": Ready")



# Helper script to load translations, as the ModLoader one seemingly does not function.
# This is not a good function, don't use it.
func updateTL(path:String = modPath + "i18n/translation.txt"):
	Debug.l(modName + ": Updating Translations")

	var tlFile = File.new()
	tlFile.open(path, File.READ)

	var translation = Translation.new()
	translation.locale = "en"

	while tlFile.get_position() < tlFile.get_len():
		var line = tlFile.get_line()
		var split = line.split("|", false)
		if split.size() == 2:
			translation.add_message(split[0], tr(split[1]).c_unescape())
			Debug.l(str("Added translation: ", split))

	TranslationServer.add_translation(translation)

	Debug.l(modName + ": Translations Updated")


# Helper function to extend scripts
func installScriptExtension(path:String , oldPath:String = "none"):
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
