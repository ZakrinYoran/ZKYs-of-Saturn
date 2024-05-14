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
	installScriptExtension("ships/ship-ctrl.gd")
	installScriptExtension("asteroids/mineral.gd")
	installScriptExtension("AsteroidSpawner.gd")
	installScriptExtension("CurrentGame.gd")
	installScriptExtension("TheRing.gd")

	Debug.l(modName + ": Initialized")


#Don't got nothin to do on ready
func _ready():
	Debug.l(modName + ": Ready")


# Helper function to extend scripts
func installScriptExtension(path:String , oldPath:String = "none"):
	var childPath = str(modPath + path)
	var childScript = ResourceLoader.load(childPath)

	childScript.new()

	var parentScript = childScript.get_base_script()
	var parentPath = parentScript.resource_path

	Debug.l("Installing script extension: %s <- %s" % [parentPath, childPath])

	childScript.take_over_path(parentPath)

