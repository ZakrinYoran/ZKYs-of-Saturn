extends "res://menu/SettingsLayer.gd"

func _on_Save_pressed():
	Settings.saveZKYToFile()
	._on_Save_pressed()

func _on_Cancel_pressed():
	Settings.loadZKYFromFile()
	get_tree().call_group("ZKYSettings", "updateSettings")
	._on_Cancel_pressed()
