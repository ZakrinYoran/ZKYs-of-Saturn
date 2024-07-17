extends "res://ships/modules/MineralProcessingUnit.gd"

#const IS_MPU = true

# Set so that it shows up in the OMS
var mineralTargetting = true
# It's an MPU, we only want minerals
var onlyMinerals = true
# The filter that will determine what minerals we store
var mineralConfig = []




func _ready():
	#If we're mineraltargeting
	if mineralTargetting:
		#Get the filter from the ship
		mineralConfig = ship.getConfig("cargo.filter", [])
		#If the filter is empty
		if mineralConfig.empty():
			#Set the filter to all minerals
			mineralConfig = CurrentGame.traceMinerals.duplicate()
			#Set the ship config
			ship.setConfig("cargo.filter", mineralConfig)


#Enables/Disables given mineral, called whenever geologist filters are changed
func setMineralConfig(mineral:String, how:bool):
	if mineralTargetting:
		if how:
			if not mineralConfig.has(mineral):
				mineralConfig.append(mineral)
		else :
			mineralConfig.erase(mineral)
#	print(mineralConfig)


#Checks if the mineral is enabled, used by  the geologist menu to determine what buttons should be pressed
func hasMineralEnabled(mineral)->bool:
	if mineralTargetting:
		return mineralConfig.has(mineral)
	else :
		return false


#This is such hot garbage
func _physics_process(delta):
	#If the MPU is enabled
	if enabled:
		#For every entity in the processing bay
		for p in processing:
			#If we can claim the entity
			if Tool.claim(p):
				#Check if it's a valid mineral chunk about to be processed
				if "comp_val" in p and (p.fillerContent < 0.05 or p.mass < 0.02):
					#For every material in the chunk
					for type in p.composition:
						#If the material is not the filler AND it's not disabled in the geologist menu
						if type != p.filler and type in mineralConfig:
							#Calculate how much of the mineral to store
							var store = 1000 * p.composition[type] * mineralEfficiency
							#Try to store the mineral in the ship
							var got = ship.addProcessedCargo(type, store, ship.getProcessedCargoCapacity(type) + internalStorage)

							#Vent excess material.... I think, tbh I just assumed I should keep this code
							if got > 0:
								var t = 1 - (store / got)
								ventingMineral = ventTime * t
							else :
								ventingMineral = ventTime

				Tool.release(p)
