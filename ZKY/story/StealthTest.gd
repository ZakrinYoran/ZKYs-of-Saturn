extends Node

export var chaosLimit = 0.3
export var minCapacity = 0.6
export var minMoney = 30000
export var disabled:bool = false

func canBeAt(pos):
	if disabled:
		return false

	match Settings.getDifficulty():
		0:
			return false
		1:
			if CurrentGame.getMoney() < minMoney:
				return false
			if CurrentGame.getPlayerShip().getCombatCapacity() < minCapacity:
				return false
			
	var chaos = get_parent().getChaosAt(pos)
	Debug.l("Testing for chaos on %s: %f/%f" % [name, chaos, chaosLimit])
	return chaos > chaosLimit

func makeAt(pos):
	var instance = Shipyard.createShipByConfig({
		"model":"TRTL-STEALTH", 
		"faction":"secret", 
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
	})
	instance.preheat = true
	instance.ai = true
	instance.transponder = ""
	Debug.l("Spawning Stealth Test")
	return instance
