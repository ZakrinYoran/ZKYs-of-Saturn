extends "res://AsteroidSpawner.gd"

#Load new mineral roids
func _init():
	objectClass[objectClass.size()-1].merge({
	"Au":[
		preload("res://MoreMinerals/asteroids/mineral-au-1.tscn"),
		preload("res://MoreMinerals/asteroids/mineral-au-2.tscn"),
		preload("res://MoreMinerals/asteroids/mineral-au-3.tscn"),
		preload("res://MoreMinerals/asteroids/mineral-au-4.tscn"),
		preload("res://MoreMinerals/asteroids/mineral-au-5.tscn"),
		preload("res://MoreMinerals/asteroids/mineral-au-6.tscn"),
		preload("res://MoreMinerals/asteroids/mineral-au-7.tscn"),
		],
	"Cu":[
		preload("res://MoreMinerals/asteroids/mineral-cu-1.tscn"),
		preload("res://MoreMinerals/asteroids/mineral-cu-2.tscn"),
		preload("res://MoreMinerals/asteroids/mineral-cu-3.tscn"),
		preload("res://MoreMinerals/asteroids/mineral-cu-4.tscn"),
		preload("res://MoreMinerals/asteroids/mineral-cu-5.tscn"),
		preload("res://MoreMinerals/asteroids/mineral-cu-6.tscn"),
		preload("res://MoreMinerals/asteroids/mineral-cu-7.tscn"),
		],
	"Mg":[
		preload("res://MoreMinerals/asteroids/mineral-mg-1.tscn"),
		preload("res://MoreMinerals/asteroids/mineral-mg-2.tscn"),
		preload("res://MoreMinerals/asteroids/mineral-mg-3.tscn"),
		preload("res://MoreMinerals/asteroids/mineral-mg-4.tscn"),
		preload("res://MoreMinerals/asteroids/mineral-mg-5.tscn"),
		preload("res://MoreMinerals/asteroids/mineral-mg-6.tscn"),
		preload("res://MoreMinerals/asteroids/mineral-mg-7.tscn"),
		],
	"Ni":[
		preload("res://MoreMinerals/asteroids/mineral-ni-1.tscn"),
		preload("res://MoreMinerals/asteroids/mineral-ni-2.tscn"),
		preload("res://MoreMinerals/asteroids/mineral-ni-3.tscn"),
		preload("res://MoreMinerals/asteroids/mineral-ni-4.tscn"),
		preload("res://MoreMinerals/asteroids/mineral-ni-5.tscn"),
		preload("res://MoreMinerals/asteroids/mineral-ni-6.tscn"),
		preload("res://MoreMinerals/asteroids/mineral-ni-7.tscn"),
		],
	"Re":[
		preload("res://MoreMinerals/asteroids/mineral-re-1.tscn"),
		preload("res://MoreMinerals/asteroids/mineral-re-2.tscn"),
		preload("res://MoreMinerals/asteroids/mineral-re-3.tscn"),
		preload("res://MoreMinerals/asteroids/mineral-re-4.tscn"),
		preload("res://MoreMinerals/asteroids/mineral-re-5.tscn"),
		preload("res://MoreMinerals/asteroids/mineral-re-6.tscn"),
		preload("res://MoreMinerals/asteroids/mineral-re-7.tscn"),
		],
	"Ti":[
		preload("res://MoreMinerals/asteroids/mineral-ti-1.tscn"),
		preload("res://MoreMinerals/asteroids/mineral-ti-2.tscn"),
		preload("res://MoreMinerals/asteroids/mineral-ti-3.tscn"),
		preload("res://MoreMinerals/asteroids/mineral-ti-4.tscn"),
		preload("res://MoreMinerals/asteroids/mineral-ti-5.tscn"),
		preload("res://MoreMinerals/asteroids/mineral-ti-6.tscn"),
		preload("res://MoreMinerals/asteroids/mineral-ti-7.tscn"),
		],
})


func spawnAsteroidByClass(oc, spot, chaos, spawnPointRandomness = 0.0, initialLinearVelocity = Vector2(0, 0), initialAngularVelocity = 0.0, tries = 1, spawned = true):
	#Generate the asteroid normally
	var i = .spawnAsteroidByClass(oc, spot, chaos, spawnPointRandomness, initialLinearVelocity, initialAngularVelocity, tries, spawned)
	
	
	#If it's a class 5 roid, it's a mineral chunk
	if oc == 5 and i:
		var pure : float
		var impure : float

		#How many minerals are possible
		var sm : int = randi() % 3

		#If there are sub-minerals possible
		if sm > 0:
			#How much of the mineral should remain its base type
			pure = i.composition[i.mineral] * range_lerp(i.purity, 0.0, 1.0, 0.5, 0.9) #maps the purity to between 0.5 and 0.9
			#How much of the mineral should become a different mineral
			impure = i.composition[i.mineral] - pure
			#Set the mineral to its new quantity
			i.composition[i.mineral] = pure

		#While we have uncalculated sub-minerals AND 1kg of impurity remaining
		while sm > 0 and impure > 0.001:
			#Remove 1 sub-mineral from the count
			sm -= 1
			#Get mineral vein
			var m : String = getVeinAt(CurrentGame.globalCoords(spot))

			#Quantity of mineral
			var q : float
			#While there is more than one sub-mineral remaining
			if sm > 0:
				#Choose how much of the impurity should be the new mineral
				q = rand_range(0, impure)
				#Reduce the impurity left by that amount
				impure -= q
			#If this is the last sub-mineral
			else:
				#The remaining quantity should be this mineral
				q = impure
				impure = 0

			#If the roid already has that mineral
			if i.composition[m]:
				#Add it to the existing amount
				i.composition[m] += q
			#If the roid does not have that mineral
			else:
				#Add it to the roid
				i.composition[m] = q

		i.update_mass()

	return i
