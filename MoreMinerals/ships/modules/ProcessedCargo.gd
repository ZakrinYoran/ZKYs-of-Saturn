extends Node


# name of the equipment
var systemName = "SYSTEM_CARGO_PROCESSED"
# The equipment slot on the ship
var slot = "cargo.processed"
# Set so that it shows up in the OMS
var mineralTargetting = true
# We only want minerals
var onlyMinerals = true
# The filter that will determine what minerals we store
var mineralConfig = []
# How quickly the ship can purge minerals
var dumpRate = 500.0

# The ship we belong to
var ship
# Any equiment that can hold minerals
var containers = []


# Needed for the ship to detect it as a system
func getStatus():
	return 100


# Returns how full the processed cargo is, used to modulate the equipment brightness on the HUD
func getPower():
	var t : float = ship.getTotalProcessedCargoCapacity()
	var c : float = 0.0
	for m in ship.shipConfig.processedCargo:
		c += ship.shipConfig.processedCargo[m]

	return (c / t)


# Called when the node enters the scene tree for the first time.
func _ready():
	ship = getShip()
	ship.connect("systemsChanged", self, "getSystems")
	#If we're mineraltargeting
	if mineralTargetting:
		#Get the filter from the ship
		mineralConfig = ship.getConfig("cargo.pfilter", [])


#Enables/Disables given mineral, called whenever geologist filters are changed
func setMineralConfig(mineral:String, how:bool):
	if mineralTargetting:
		if !how:
			if not mineralConfig.has(mineral):
				mineralConfig.append(mineral)
		else :
			mineralConfig.erase(mineral)

	setFilters()


#Checks if the mineral is enabled, used by  the geologist menu to determine what buttons should be pressed
func hasMineralEnabled(mineral)->bool:
	if mineralTargetting:
		return !mineralConfig.has(mineral)
	else :
		return false


func _physics_process(delta):
#	Check what minerals we need to handle this tick
	for m in mineralConfig:

#	Check if any containers have empty space
		var dump = true
		for c in containers:
			if Tool.claim(c):
				if c.enabled and c.locked and c.mineralTargetting and c.mineralConfig.minerals.has(m):
					if Tool.claim(c.target):
						if c.target.getProcessedCargo(m) < c.target.getProcessedCargoCapacity(m):
							dump = false
							Tool.release(c.target)
							Tool.release(c)
							break
						Tool.release(c.target)
				Tool.release(c)

#	If there is no empty space, dump the mineral
		if dump:
			dumpMineral(m, delta)



func dumpMineral(m, d):
	var dumped = ship.removeProcessedCargo(m, dumpRate*d)


# Get the ship we belong to
func getShip():
	var c = self
	while not c.has_method("getConfig") and c != null:
		c = c.get_parent()
	return c


# Get references to the systems we need
func getSystems(systems):
	containers = []
	for id in systems:
		var s = systems[id].ref

		if "system" in s:
			if "IS_ARM" in s.system:
				containers.append(s.system)

	setFilters()


func setFilters():
	for c in containers:
		if Tool.claim(c):
			c.dumpFilter = mineralConfig
			Tool.release(c)


# Shows what minerals are in the ship on the OMS
func getMineralInTarget(mineral)->float:
	if Tool.claim(ship):
		var ret = ship.getProcessedCargo(mineral)
		Tool.release(ship)
		return ret
	return 0.0
