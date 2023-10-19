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
var ZKYMineralPrices = {
	"Au" : 8.2,
	"Cu" : 1.6,
	"Mg" : 0.8,
	"Ni" : 1.1,
	"Re" : 16.3,
	"Ti" : 4.3,
}

# Colors of the new minerals
var ZKYMineralColors = {
	"Au":Color("e6cf00"),
	"Cu":Color("d48237"),
	"Mg":Color("5DA87C"),
	"Ni":Color("ccc3a7"),
	"Re":Color("5E5E5E"),
	"Ti":Color("9797c2"),
}

# Add the new minerals to the list of elements that can be in roids
var ZKYTraceMinerals =  [
	"Au", #Similar in price to W, but with smaller average chunks
	"Cu", #Fills the gap between Fe and the valuable ones
	"Mg", #Light but very inexpensive
	"Ni", #Slightly more valuable but less common than Fe
	"Re", #Very valuable, but very impure. High water content makes it harder to process, but not fly away like Be
	"Ti", #Lighter than most, slightly more expensive than normal
]

# Extra transponder formats
var ZKYTransponderFormats = [
	"ZKY-%s",
]

# Extra ships that will appear used at the dealership
var ZKYUsedShipsPool = [
	{"name":"AT225-H", "age":24 * 3600 * 365 * 200},
	{"name":"OCP209-M", "age":24 * 3600 * 365 * 200},
]


func _ready():
	add_to_group("ZKYSettings")
	updateSettings()

# Merge the modded minerals with the vanilla ones
	if Settings.ZKYConfig["additions"]["addMinerals"]:
		mineralPrices.merge(ZKYMineralPrices)
		specificMineralColors.merge(ZKYMineralColors)
		traceMinerals.append_array(ZKYTraceMinerals)

# Add the new transponder formats
	if Settings.ZKYConfig["additions"]["addTransponders"]:
		transponderFormats.append_array(ZKYTransponderFormats)

# Add ships to the used ship pool
	if Settings.ZKYConfig["additions"]["addShips"]:
		usedShipsPool.append_array(ZKYUsedShipsPool)

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



onready var baseNormalXpGain = normalXpGain
onready var baseMentorXpGain = mentorXpGain

onready var baseMineralPrices = mineralPrices.duplicate()

func updateSettings():
	# Adjust crew XP gains
	normalXpGain = baseNormalXpGain * Settings.ZKYConfig["gameTweaks"]["xpAdjust"]
	mentorXpGain = baseMentorXpGain * Settings.ZKYConfig["gameTweaks"]["xpAdjust"]

# Adjust the prices of modded minerals before we merge them with the vanilla ones
	for m in ZKYMineralPrices:
		mineralPrices[m] = ZKYMineralPrices[m] * Settings.ZKYConfig["gameTweaks"]["modMineralPriceAdjust"]

# Adjust the prices of vanilla minerals before we merge them with the modded ones
	for m in baseMineralPrices:
		mineralPrices[m] = baseMineralPrices[m] * Settings.ZKYConfig["gameTweaks"]["vanillaMineralPriceAdjust"]
