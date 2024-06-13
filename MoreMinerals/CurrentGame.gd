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
	"Au" : 8.2,
	"Cu" : 1.6,
	"Mg" : 0.8,
	"Ni" : 1.1,
	"Re" : 16.3,
	"Ti" : 4.3,
})

	#What color the minerals will be on the HUD/Market
	specificMineralColors.merge({
	"Au":Color("e6cf00"),
	"Cu":Color("d48237"),
	"Mg":Color("5DA87C"),
	"Ni":Color("ccc3a7"),
	"Re":Color("5E5E5E"),
	"Ti":Color("9797c2"),
})

	#Adds the minerals to the list of minerals that can be found in roids
	traceMinerals.append_array([
	"Au", #Similar in price to W, but with smaller average chunks
	"Cu", #Fills the gap between Fe and the valuable ones
	"Mg", #Light but very inexpensive
	"Ni", #Slightly more valuable but less common than Fe
	"Re", #Very valuable, but very impure. High water content makes it harder to process, but not fly away like Be
	"Ti", #Lighter than most, slightly more expensive than normal
])
