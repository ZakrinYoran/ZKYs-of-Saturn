extends "res://ships/ship-ctrl.gd"


const baseMineralCount = 6.0

var extendedMineralCount = 6.0
var cargoCapacityModifier = 1.0

var cargoBehavior = "limited" #[default, reduced, limited, dynamic]
var maxCargoTypes = 6 #For use with "limited" and "dynamic" cargo behaviors

func _ready():
	extendedMineralCount = float(CurrentGame.traceMinerals.size())
	cargoCapacityModifier = (baseMineralCount / extendedMineralCount)


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
