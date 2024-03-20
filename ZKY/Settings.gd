extends "res://Settings.gd"

# Mod version
const ZKY_VERSION = "0.6.0"

# Default config values
var ZKYConfig = {
	"modSettings":{
		"loadDLC":true,
		"loadTL":true,
		"updateVersion":true,
		"settingsMenu":true,
	}, 
	"modTesting":{
		"testEvent":false,
		"toolWindow":false,
	},
	"gameTweaks":{
		"menuStopsAstro":true,
		"escapeVelocity":200,
		"warningVelocity":150,
		"mapBoundries":true,
		"vanillaMineralPriceAdjust":1,
		"modMineralPriceAdjust":1,
		"xpAdjust":1,
	}, 
	"additions":{
		"addTransponders":true,
		"addCrewNames":true,
		"addMinerals":false,
		"addShips":true,
		"addEquipment":true,
		"addEvents":true,
	}, 
	"cargoTweaks":{
		"processedBehavior":"limited",
		"processedTypes":6,
		"canToggleColumn":true,
		"canDumpProcessed":true,
		"canKeepProcessed":false,
	}, 
	"eventTweaks":{
		"oddityAdjust":1,
		"diggerAdjust":1,
	}, 
	"sillyStuff":{
		"addATK222222225":false,
		"addATK225-HH":false,
		"addNyanShip":false,
	},
	"input":{
		"autopilot_flip_heading":[ "R" ],
		"toggle_mpu":[ "M" ],
		"action_modifier":[ "Shift" ],
	}, 
}


var ZKYPath = "user://ZKYsettings.cfg"
var ZKYFile = ConfigFile.new()

func _ready():
	loadZKYFromFile()
	saveZKYToFile()


func saveZKYToFile():
	for section in ZKYConfig:
		for key in ZKYConfig[section]:
			ZKYFile.set_value(section, key, ZKYConfig[section][key])
	ZKYFile.save(ZKYPath)


func loadZKYFromFile():
	var error = ZKYFile.load(ZKYPath)
	if error != OK:
		Debug.l("ZKY: Error loading settings %s" % error)
		return 
	for section in ZKYConfig:
		for key in ZKYConfig[section]:
			ZKYConfig[section][key] = ZKYFile.get_value(section, key, ZKYConfig[section][key])
	loadZKYKeymapFromConfig()


func loadZKYKeymapFromConfig():
	for action_name in ZKYConfig.input:
		InputMap.add_action(action_name)
		for key in ZKYConfig.input[action_name]:
			var event = InputEventKey.new()
			event.scancode = OS.find_scancode_from_string(key)
			InputMap.action_add_event(action_name, event)
	emit_signal("controlSchemeChaged")
