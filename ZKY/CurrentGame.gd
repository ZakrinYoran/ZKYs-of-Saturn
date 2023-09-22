extends "res://CurrentGame.gd"

# Reference values for me
#var mineralPrices = {
#	"H2O":0.1, 
#	"Be":20.5, 
#	"Fe":0.9, 
#	"Pd":2.5, 
#	"Pt":2.7, 
#	"V":3.0, 
#	"W":6.5,
#}

# Initial values when starting a new game
#var initialState = {
#	"seed":0, 
#	"ship":{}, 
#	"crew":{}, 
#	"storage":{
#		"minerals":{}, 
#		"oddities":[]
#	}, 
#	"money":20000, 
#	"insurance":100000, 
#	"time":0, 
#	"story":{}, 
#	"logs":[], 
#	"wages":{}, 
#	"astrogation":{}, 
#	"agenda":{}, 
#	"agendaStory":{}, 
#	"garage":[], 
#	"soldShips":[], 
#	"ui":{}, 
#	"playtime":{}, 
#	"hash":null, 
#	"hashVersion":hashVersion, 
#	"density":{
#		"map":{}, 
#		"queue":[]
#	}
#}


# Prices of the new minerals
var extendedMineralPrices = {
	"Au" : 8.2,
	"Cu" : 1.6,
	"Mg" : 0.8,
	"Ni" : 1.1,
	"Re" : 16.3,
	"Ti" : 4.3,
}

# Colors of the new minerals
var extendedMineralColors = {
	"Au":Color("e6cf00"),
	"Cu":Color("d48237"),
	"Mg":Color("5DA87C"),
	"Ni":Color("ccc3a7"),
	"Re":Color("5E5E5E"),
	"Ti":Color("9797c2"),
}

# Add the new minerals to the list of elements that can be in roids
var extendedTraceMinerals =  [
	"Au", #Similar in price to W, but with smaller average chunks
	"Cu", #Fills the gap between Fe and the valuable ones
	"Mg", #Light but very inexpensive
	"Ni", #Slightly more valuable but less common than Fe
	"Re", #Very valuable, but very impure. High water content makes it harder to process, but not fly away like Be
	"Ti", #Lighter than most, slightly more expensive than normal
]

# Extra transponder formats
var extendedTransponderFormats = [
	"ZKY-%s",
]

# Extra ships that will appear used at the dealership
var extendedUsedShipsPool = [
	{"name":"AT225-H", "age":24 * 3600 * 365 * 200},
	{"name":"OCP209-M", "age":24 * 3600 * 365 * 200},
]


func _ready():
# Adjust crew XP gains
	if Settings.ZKYConfig["gameTweaks"]["xpAdjust"] != 1:
		normalXpGain *= Settings.ZKYConfig["gameTweaks"]["xpAdjust"]
		mentorXpGain *= Settings.ZKYConfig["gameTweaks"]["xpAdjust"]

# Adjust the prices of modded minerals before we merge them with the vanilla ones
	if Settings.ZKYConfig["gameTweaks"]["modMineralPriceAdjust"] != 1:
		for m in extendedMineralPrices:
			extendedMineralPrices[m] *= Settings.ZKYConfig["gameTweaks"]["modMineralPriceAdjust"]

# Adjust the prices of vanilla minerals before we merge them with the modded ones
	if Settings.ZKYConfig["gameTweaks"]["vanillaMineralPriceAdjust"] != 1:
		for m in mineralPrices:
			mineralPrices[m] *= Settings.ZKYConfig["gameTweaks"]["vanillaMineralPriceAdjust"]

# Merge the modded minerals with the vanilla ones
	if Settings.ZKYConfig["additions"]["addMinerals"]:
		mineralPrices.merge(extendedMineralPrices)
		specificMineralColors.merge(extendedMineralColors)
		traceMinerals.append_array(extendedTraceMinerals)

# Add the new transponder formats
	if Settings.ZKYConfig["additions"]["addTransponders"]:
		transponderFormats.append_array(extendedTransponderFormats)

# Add ships to the used ship pool
	if Settings.ZKYConfig["additions"]["addShips"]:
		usedShipsPool.append_array(extendedUsedShipsPool)

# Add the ATK222222225 to the used ships pool
	if Settings.ZKYConfig["sillyStuff"]["addATK222222225"]:
		usedShipsPool.append({"name":"AT222222225", "age":24 * 3600 * 365 * 200})

# Add the ATK225-HH to the used ships pool
	if Settings.ZKYConfig["sillyStuff"]["addATK225-HH"]:
		usedShipsPool.append({"name":"AT225-HH", "age":24 * 3600 * 365 * 200})

# WIP is weird, deal with this when you have braincells
# Should in theory add a ship to the pool of 'new' ships at the dealer
#func getShipsAvailableForSale():
#	var now = getInGameTimestamp()
#	var day = int(floor(now / (24 * 3600)))
#	var week = int(day / 7) * 7 + 500000.0
#
#	var ships = []
#	ships.append(createShipInstanceWithCache("TRTL-STEALTH", 24 * 3600 * 7, week + 4, true))
#	ships.append_array(.getShipsAvailableForSale())
#	return ships
