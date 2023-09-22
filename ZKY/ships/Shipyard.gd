extends "res://ships/Shipyard.gd"


func _ready():
	addStealthTurtle()

	if Settings.ZKYConfig["additions"]["addShips"]:
		addK225H()
		addOCP209M()

	if Settings.ZKYConfig["sillyStuff"]["addATK222222225"]:
		addK222222225()

	if Settings.ZKYConfig["sillyStuff"]["addATK225-HH"]:
		addK225HH()


func addK225H():
	ships["AT225-H"] = preload("res://ZKY/ships/ATK225-H.tscn")
	configAlias["AT225-H"] = "AT225"
	defaultShipConfig["AT225-H"] = {
		"config":{
			"weaponSlot":{
				"middleRight":{
					"type":"SYSTEM_EMD14"
				}, 
				"middleLeft":{
					"type":"SYSTEM_NONE"
				}, 
				"leftBay1":{
					"type":"SYSTEM_EXSTORAGE-L"
				}, 
				"rightBay1":{
					"type":"SYSTEM_EXSTORAGE-R"
				}, 
			}, 
			"reactor":{
				"power":16.0
			}, 
			"ammo":{
				"capacity":1000.0, 
				"initial":1000.0, 
			}, 
			"fuel":{
				"capacity":80000.0, 
				"initial":80000.0, 
			}, 
			"capacitor":{
				"capacity":500.0, 
			}, 
			"turbine":{
				"power":200.0, 
			}, 
			"shielding":{
				"emp":0, 
			}, 
			"cargo":{
				"equipment":"SYSTEM_CARGO_MPUFSO"
			}, 
			"autopilot":{
				"type":"SYSTEM_AUTOPILOT_MK2"
			}, 
			"propulsion":{
				"main":"SYSTEM_MAIN_ENGINE_BWMT535", 
				"rcs":"SYSTEM_THRUSTER_K37"
			}, 
			"hud":{
				"type":"SYSTEM_HUD_AT225"
			}, 
		}
	}

func addOCP209M():
	ships["OCP209-M"] = preload("res://ZKY/ships/OCP-209-M.tscn")
	configAlias["OCP209-M"] = "OCP209"
	defaultShipConfig["OCP209-M"] = {
		"config":{
			"hud":{
				"type":"SYSTEM_HUD_OCP209"
			}, 
			"aux":{
				"power":"SYSTEM_AUX_SMES"
				}, 
			"weaponSlot":{
				"main":{
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

func addK222222225():
	ships["AT222222225"] = preload("res://ZKY/silly/K222222225/ships/ATK222222225.tscn")
	configAlias["AT222222225"] = "AT225"
	defaultShipConfig["AT222222225"] = {
		"config":{
			"weaponSlot":{
				"middleRight":{
					"type":"SYSTEM_EMD14"
				}, 
				"middleLeft":{
					"type":"SYSTEM_NONE"
				}, 
				"leftBay1":{
					"type":"SYSTEM_EXSTORAGE-L"
				}, 
				"leftBay2":{
					"type":"SYSTEM_EXSTORAGE-L"
				}, 
				"leftBay3":{
					"type":"SYSTEM_EXSTORAGE-L"
				}, 
				"leftBay4":{
					"type":"SYSTEM_EXSTORAGE-L"
				}, 
				"leftBay5":{
					"type":"SYSTEM_EXSTORAGE-L"
				}, 
				"rightBay1":{
					"type":"SYSTEM_EXSTORAGE-R"
				}, 
				"rightBay2":{
					"type":"SYSTEM_EXSTORAGE-R"
				}, 
				"rightBay3":{
					"type":"SYSTEM_EXSTORAGE-R"
				}, 
				"rightBay4":{
					"type":"SYSTEM_EXSTORAGE-R"
				}, 
				"rightBay5":{
					"type":"SYSTEM_EXSTORAGE-R"
				}, 
			}, 
			"reactor":{
				"power":20.0
			}, 
			"ammo":{
				"capacity":1000.0, 
				"initial":1000.0, 
			}, 
			"fuel":{
				"capacity":80000.0, 
				"initial":80000.0, 
			}, 
			"capacitor":{
				"capacity":500.0, 
			}, 
			"turbine":{
				"power":200.0, 
			}, 
			"shielding":{
				"emp":0, 
			}, 
			"cargo":{
				"equipment":"SYSTEM_CARGO_MPUFSO"
			}, 
			"autopilot":{
				"type":"SYSTEM_AUTOPILOT_MK2"
			}, 
			"propulsion":{
				"main":"SYSTEM_MAIN_ENGINE_BWMT535", 
				"rcs":"SYSTEM_THRUSTER_K37"
			}, 
			"hud":{
				"type":"SYSTEM_HUD_AT222222225"
			}, 
		}
	}

func addK225HH():
	ships["AT225-HH"] = preload("res://ZKY/silly/K225-HH/ships/ATK225-HH.tscn")
	configAlias["AT225-HH"] = "AT225"
	defaultShipConfig["AT225-HH"] = {
		"config":{
			"weaponSlot":{
				"mainFrontRight":{
					"type":"SYSTEM_EMD14"
				}, 
			}, 
			"reactor":{
				"power":16.0
			}, 
			"ammo":{
				"capacity":1000.0, 
				"initial":1000.0, 
			}, 
			"fuel":{
				"capacity":80000.0, 
				"initial":80000.0, 
			}, 
			"capacitor":{
				"capacity":500.0, 
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
				"main":"SYSTEM_MAIN_ENGINE_BWMT535", 
				"rcs":"SYSTEM_THRUSTER_K37"
			}, 
			"hud":{
				"type":"SYSTEM_HUD_AT225"
			}, 
		}
	}

func addStealthTurtle():
	ships["TRTL-STEALTH"] = preload("res://ZKY/ships/StealthTest.tscn")
	configAlias["TRTL-STEALTH"] = "TRTL"
	defaultShipConfig["TRTL-STEALTH"] = {
		"config":{
			"weaponSlot":{
				"main":{
					"type":"SYSTEM_EMD14"
				}
			}, 
			"reactor":{
				"power":30.0
			}, 
			"ammo":{
				"capacity":5000.0, 
				"initial":5000.0, 
			}, 
			"fuel":{
				"capacity":50000.0, 
				"initial":50000.0, 
			}, 
			"capacitor":{
				"capacity":1500.0, 
			}, 
			"turbine":{
				"power":500.0, 
			}, 
			"shielding":{
				"emp":500, 
			}, 
			"cargo":{
				"equipment":"SYSTEM_CARGO_STANDARD"
			}, 
			"autopilot":{
				"type":"SYSTEM_AUTOPILOT_MK1"
			},
			"propulsion":{
				"main":"SYSTEM_MAIN_ENGINE_K44", 
				"rcs":"SYSTEM_THRUSTER_MA350HO"
			}
		}
	}
