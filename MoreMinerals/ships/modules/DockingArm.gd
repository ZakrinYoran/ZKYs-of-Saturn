extends "res://ships/modules/DockingArm.gd"

#Used to determine if this is a possible valid container
const IS_ARM = true
#What minerals the ship is trying to purge
var dumpFilter = []
#How fast we can transfer minerals
var modProcessedCargoTransferSpeed


func _ready():
#	Set our transfer speed
	modProcessedCargoTransferSpeed = processedCargoTransferSpeed
#	Override to prevent the base script from attempting cargo transfers
	processedCargoTransferSpeed = 0


func _physics_process(delta):
	var transfering = false
#	Calculate how much we can transfer this physics tick
	var oreTransfer = delta * modProcessedCargoTransferSpeed

#	If the arm is enabled, and locked onto a container
	if delta > 0 and enabled and locked and Tool.claim(target):
#	If we can transfer ore:
		if oreTransfer > 0 and Tool.claim(ship):
#		Calculate energy requirement
			var er = oreTransfer * processedCargoPowerPerKg
#		Attempt to consume power from the ship
			var p = ship.drawEnergy(er)

#		If we have enough energy
			if (er > 0 and p / er > 0.9):

#			For every mineral that the ship has
				for mineral in ship.getProcessedCargoTypes():

#				If the arm is accepting that mineral
					if hasMineralEnabled(mineral):
#					Defaults to 0 incase ship is purging the mineral
						var onShip = 0
#					Capacity of the object the arm is holding
						var tppc = target.getProcessedCargoCapacity(mineral)
#					If the ship is not purging that mineral
						if !dumpFilter.has(mineral):
#						Leave the transfer buffer
							onShip = processedCargoTransferBuffer

#					Amount currently in the object the arm is holding
						var targetCargo = target.getProcessedCargo(mineral)
#					Amount currently in the ship, adjusted for the transfer buffer if applicable
						var sourceCargo = max(ship.getProcessedCargo(mineral) - onShip, 0)

#					Calculate amount to transfer:
#					Get what is lower: How much the container can hold or how much we can transfer
						var tam = min(
#						Calculates how much room the container has for that mineral
							tppc - targetCargo, 
#						Get what is lower: the amount we can transfer, or the amount that the ship holds
							min(oreTransfer, sourceCargo))

#					If we are transfering
						if tam > 0:
							transfering = true
#						Remove the mineral from the ship
							var a = ship.removeProcessedCargo(mineral, tam)
#						Add it to the container
							target.addProcessedCargo(mineral, a, tppc)

#			For every mineral that the container has
				for mineral in target.getProcessedCargoTypes():

#				If the ship is not purging that mineral
					if !dumpFilter.has(mineral):
#					Capacity of the ship for that mineral
						var tppc = ship.getProcessedCargoCapacity(mineral)
#					How much we want to put on the ship
						var onShip = processedCargoTransferBuffer if hasMineralEnabled(mineral) else tppc
#					How much is on the ship
						var targetCargo = ship.getProcessedCargo(mineral)
#					How much is in the container
						var sourceCargo = target.getProcessedCargo(mineral)

#					Calculate how much to transfer
#					Get the lowest: How much the ship can hold, how much we want to add, or how much we can transfer
						var tam = min(
#						Calculates how much room the ship has
							tppc - targetCargo,
#						Calculates how much should be added to reach the desired amount
							min(onShip - targetCargo, 
#						Get what is lower: the amount we can transfer, or the amount that the container holds
							min(oreTransfer, sourceCargo)))

#				If we are transfering
						if tam > 0:
							transfering = true
#						Remove the mineral from the container
							var a = target.removeProcessedCargo(mineral, tam)
#						Add it to the ship
							ship.addProcessedCargo(mineral, a, tppc)

#		If we are transfering and the sound is not currently playing
			if transfering and !transfer.is_playing():
#			Play the transfer effect
				transfer.play()
#	NOTE: we're relying on the base script to stop playing the sound

#	Release the container and ship
			Tool.release(ship)
		Tool.release(target)


#	Modified to show minerals in OMS despite processedCargoTransferSpeed being 0 
func getMineralInTarget(mineral)->float:
	if modProcessedCargoTransferSpeed > 0:
		if Tool.claim(target):
			var ret = 0.0
			if target.has_method("getProcessedCargo"):
				ret = target.getProcessedCargo(mineral)
			Tool.release(target)
			return ret
	return 0.0
