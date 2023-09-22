extends "res://ships/Shipyard.gd"


func _ready():
	ships["OCP209-D"] = load("res://DroneOCP/ships/OCP-209-D.tscn")
	configAlias["OCP209-D"] = "OCP209"
	defaultShipConfig["OCP209-D"] = {
		"config":{
			"hud":{
				"type":"SYSTEM_HUD_OCP209"
			}, 
			"aux":{
				"power":"SYSTEM_AUX_SMES"
				}, 
			"weaponSlot":{
				"mainLeft":{
					"type":"SYSTEM_SALVAGE_ARM"
				}, 
				"mainRight":{
					"type":"SYSTEM_SALVAGE_ARM"
				}, 
			}, 
			"reactor":{
				"power":16.0
			}, 
			"ammo":{
				"capacity":0.0, 
				"initial":0.0, 
			}, 
			"fuel":{
				"capacity":80000.0, 
				"initial":80000.0, 
			}, 
			"capacitor":{
				"capacity":1000.0, 
			}, 
			"turbine":{
				"power":200.0, 
			}, 
			"shielding":{
				"emp":0, 
			}, 
			"autopilot":{
				"type":"SYSTEM_AUTOPILOT_MK2"
			}, 
			"propulsion":{
				"main":"SYSTEM_MAIN_ENGINE_DFMPD2205", 
				"rcs":"SYSTEM_THRUSTER_GHET"
			}, 
		}
	}
