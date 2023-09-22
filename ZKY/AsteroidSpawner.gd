extends "res://AsteroidSpawner.gd"

var extendedMineralScenes = {
	"Mg":[
		preload("res://ZKY/asteroids/mineral-mg-1.tscn"),
		preload("res://ZKY/asteroids/mineral-mg-2.tscn"),
		preload("res://ZKY/asteroids/mineral-mg-3.tscn"),
		preload("res://ZKY/asteroids/mineral-mg-4.tscn"),
		preload("res://ZKY/asteroids/mineral-mg-5.tscn"),
		preload("res://ZKY/asteroids/mineral-mg-6.tscn"),
		preload("res://ZKY/asteroids/mineral-mg-7.tscn"),
		],
	"Ti":[
		preload("res://ZKY/asteroids/mineral-ti-1.tscn"),
		preload("res://ZKY/asteroids/mineral-ti-2.tscn"),
		preload("res://ZKY/asteroids/mineral-ti-3.tscn"),
		preload("res://ZKY/asteroids/mineral-ti-4.tscn"),
		preload("res://ZKY/asteroids/mineral-ti-5.tscn"),
		preload("res://ZKY/asteroids/mineral-ti-6.tscn"),
		preload("res://ZKY/asteroids/mineral-ti-7.tscn"),
		],
	"Ni":[
		preload("res://ZKY/asteroids/mineral-ni-1.tscn"),
		preload("res://ZKY/asteroids/mineral-ni-2.tscn"),
		preload("res://ZKY/asteroids/mineral-ni-3.tscn"),
		preload("res://ZKY/asteroids/mineral-ni-4.tscn"),
		preload("res://ZKY/asteroids/mineral-ni-5.tscn"),
		preload("res://ZKY/asteroids/mineral-ni-6.tscn"),
		preload("res://ZKY/asteroids/mineral-ni-7.tscn"),
		],
	"Cu":[
		preload("res://ZKY/asteroids/mineral-cu-1.tscn"),
		preload("res://ZKY/asteroids/mineral-cu-2.tscn"),
		preload("res://ZKY/asteroids/mineral-cu-3.tscn"),
		preload("res://ZKY/asteroids/mineral-cu-4.tscn"),
		preload("res://ZKY/asteroids/mineral-cu-5.tscn"),
		preload("res://ZKY/asteroids/mineral-cu-6.tscn"),
		preload("res://ZKY/asteroids/mineral-cu-7.tscn"),
		],
	"Re":[
		preload("res://ZKY/asteroids/mineral-re-1.tscn"),
		preload("res://ZKY/asteroids/mineral-re-2.tscn"),
		preload("res://ZKY/asteroids/mineral-re-3.tscn"),
		preload("res://ZKY/asteroids/mineral-re-4.tscn"),
		preload("res://ZKY/asteroids/mineral-re-5.tscn"),
		preload("res://ZKY/asteroids/mineral-re-6.tscn"),
		preload("res://ZKY/asteroids/mineral-re-7.tscn"),
		],
	"Au":[
		preload("res://ZKY/asteroids/mineral-au-1.tscn"),
		preload("res://ZKY/asteroids/mineral-au-2.tscn"),
		preload("res://ZKY/asteroids/mineral-au-3.tscn"),
		preload("res://ZKY/asteroids/mineral-au-4.tscn"),
		preload("res://ZKY/asteroids/mineral-au-5.tscn"),
		preload("res://ZKY/asteroids/mineral-au-6.tscn"),
		preload("res://ZKY/asteroids/mineral-au-7.tscn"),
		]
}


func _init():
	objectClass[objectClass.size()-1].merge(extendedMineralScenes)
