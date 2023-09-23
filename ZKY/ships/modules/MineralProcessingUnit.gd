extends "res://ships/modules/MineralProcessingUnit.gd"

var mineralTargetting = true
var onlyMinerals = true

var mineralConfig = []
var mineralDumpRate = 100.0

# Toggle the MPU when the key is pressed
func _input(event):
	if !ship.cutscene and ship.isPlayerControlled():
		if event.is_action_pressed("toggle_mpu"):
			enabled = not enabled


func _ready():
	mineralConfig = CurrentGame.traceMinerals.duplicate()


func setMineralConfig(mineral:String, how:bool):
	if mineralTargetting:
		if how:
			if not mineralConfig.has(mineral):
				mineralConfig.append(mineral)
		else :
			mineralConfig.erase(mineral)


func _physics_process(delta):
	dumpCargo(delta)


func dumpCargo(delta):
	var shipCargo = ship.shipConfig.processedCargo
	for mineral in CurrentGame.traceMinerals:
		if !mineralConfig.has(mineral) and shipCargo.has(mineral):
			ship.configMutex.lock()
			shipCargo[mineral] = max(0.0, shipCargo[mineral] - (delta * mineralDumpRate))
			ship.configMutex.unlock()

