extends "res://ships/ship-ctrl.gd"


const baseMineralCount = 6.0

var extendedMineralCount = 6.0
var cargoCapacityModifier = 1.0

var cargoBehavior = "limited" #[default, reduced, limited, dynamic]
var maxCargoTypes = 6 #For use with "limited" and "dynamic" cargo behaviors

var escapeVelocity = 2000

# Set up all our variables from the config
func _ready():
	add_to_group("ZKYSettings")
	updateSettings()
	
# Disables autopilot acceleration limits
#	if isPlayerControlled():
#		autopilotComfortEnabled = false


# Update all the variables that can be changed by settings
func updateSettings():
	cargoBehavior = Settings.ZKYConfig["cargoTweaks"]["processedBehavior"]
	maxCargoTypes = int(Settings.ZKYConfig["cargoTweaks"]["processedTypes"])

	if Settings.ZKYConfig["additions"]["addMinerals"]:
		extendedMineralCount = float(CurrentGame.traceMinerals.size())
		cargoCapacityModifier = (baseMineralCount / extendedMineralCount)

	escapeVelocity = (Settings.ZKYConfig["gameTweaks"]["escapeVelocity"] * 10)


# Check if opening the OMS cancels astrogation
func inventoryModeChanged(how):
	if Settings.ZKYConfig["gameTweaks"]["menuStopsAstro"]:
		if how:
			trajectoryTarget = null
			trajectoryProgress = null


# Check if the player should be automatically returned to E by the emegency autopilot
func isInEscapeCondition():
	if test:
		return false
	if dead:
		return false
	if escapeCutscene:
		return true
	if cutscene:
		return false
	if not isPlayerControlled():
		return false
	if Settings.ZKYConfig["gameTweaks"]["mapBoundries"]:
		if CurrentGame.globalCoords(global_position).x < 0:
			return true
		if CurrentGame.globalCoords(global_position).x > 3.006e+07:
			return true
	if linear_velocity.length() > escapeVelocity:
		return true
	return false


# Get a ship's total processed cargo capacity
func getTotalProcessedCargoCapacity()->float:
	if processedCargoStorageType == "divided":
		match cargoBehavior:
			"default":
				return processedCargoCapacity * extendedMineralCount
			"reduced", "limited", "dynamic":
				return processedCargoCapacity * baseMineralCount
			_:
				return 0.0
	else:
		return .getTotalProcessedCargoCapacity()


# Get a ship's processed cargo capacity for a single mineral
func getProcessedCargoCapacity(mineral:String)->float:
	removeSchrodingersIron()
	if processedCargoStorageType == "divided":
		match cargoBehavior:

			"default":
				return .getProcessedCargoCapacity(mineral)

			"reduced":
				return (processedCargoCapacity * cargoCapacityModifier)

			"limited":
				var types = getProcessedCargoTypes()
				if types.size() > maxCargoTypes:
					return 0.0
				if types.size() == maxCargoTypes:
					if mineral in types:
						return processedCargoCapacity
					else:
						return 0.0
				return processedCargoCapacity

			"dynamic":
				var baysFree = maxCargoTypes

				for m in shipConfig.processedCargo:
					baysFree -= ceil(shipConfig.processedCargo[m] / processedCargoCapacity)

				if mineral in shipConfig.processedCargo:
					var currentBays = ceil(shipConfig.processedCargo[mineral] / processedCargoCapacity)
					return float((currentBays + baysFree) * processedCargoCapacity)
				else:
					return float(baysFree * processedCargoCapacity)
			_:
				return 0.0
	else:
		return .getProcessedCargoCapacity(mineral)


# Remove any processed cargo listings if it has 0 or less of that mineral.
# This prevents weird bugs with some custom cargo implementations, as the ship would start with 0 Iron in the hold.
func removeSchrodingersIron():
	configMutex.lock()
	for mineral in shipConfig.processedCargo:
		if shipConfig.processedCargo[mineral] <= 0:
			shipConfig.processedCargo.erase(mineral)
	configMutex.unlock()


# WIP, keeps processed cargo in the hold, so you can bring it with you next dive
func emptyUnprocessedCargo():
	configMutex.lock()
	shipConfig.currentCargo.clear()
	shipConfig.currentCargoBy.clear()
	configMutex.unlock()


# Functions to disable/reenable collisions on a ship
var defaultCollisions = {}
func disableCollisionsOn(obj):
	if "collision_layer" in obj:
		defaultCollisions[obj] = {
			"mask" : obj.collision_mask,
			"layer" : obj.collision_layer
		}
	.disableCollisionsOn(obj)


func enableCollisions():
	for obj in defaultCollisions:
		obj.collision_mask = defaultCollisions[obj]["mask"]
		obj.collision_layer = defaultCollisions[obj]["layer"]


# Functions to invert autopilot heading.
# Credit to cxcorp for the original implementation.
var _autopilotManualHeadingFlipped: bool = false

func _enter_tree():
	_autopilotManualHeadingFlipped = false
	.enter_tree()

func _onDespawn():
	_autopilotManualHeadingFlipped = false
	._onDespawn()

func manualControl(delta):
	.manualControl(delta)
	if Input.is_action_pressed("autopilot_orient_to_mouse") and ( not queueTargetting or mouseQueueClickTime > autopilotMouseDeadTime):
		if _autopilotManualHeadingFlipped:
			var a = autopilotDesiredRotation
			a += PI
			if a > 2 * PI:
				a -= 2 * PI
			autopilotDesiredRotation = a

	if Input.is_action_just_pressed("autopilot_flip_heading"):
			_autopilotManualHeadingFlipped = not _autopilotManualHeadingFlipped
			autopilotDesiredRotation += PI
			if autopilotDesiredRotation > 2 * PI:
				autopilotDesiredRotation -= 2 * PI
