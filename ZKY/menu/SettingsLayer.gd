extends "res://menu/SettingsLayer.gd"


func _on_Save_pressed():
	Settings.saveZKYToFile()
	get_tree().call_group("ZKYSettings", "updateSettings")
	._on_Save_pressed()

func cancel():
	Settings.needRestart = false
	Settings.loadZKYFromFile()
	get_tree().call_group("ZKYSettings", "updateSettings")
	.cancel()
