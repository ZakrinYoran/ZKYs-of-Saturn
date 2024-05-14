extends "res://CurrentGame.gd"

#Reference numbers
#var mineralPrices = {
#	"H2O":0.1, 
#	"Be":20.5, 
#	"Fe":0.9, 
#	"Pd":2.5, 
#	"Pt":2.7, 
#	"V":3.0, 
#	"W":6.5
#}


# Merge the modded minerals with the vanilla ones
func _ready():
	#The prices of the minerals
	mineralPrices.merge({
	"Au" : 5.8,
	"Ag" : 8.6,
	"Si" : 2.6,
})

	#What color the minerals will be on the HUD/Market
	specificMineralColors.merge({
	"Au":Color("02ad0a"),
	"Ag":Color("c2c1b6"),
	"Si":Color("bfbfb4"),
})

	#Adds the minerals to the list of minerals that can be found in roids
	traceMinerals.append_array([
	"Au",
	"Ag",
	"Si",
])
