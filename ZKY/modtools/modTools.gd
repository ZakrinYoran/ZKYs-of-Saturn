extends PanelContainer

var held = false
var resize = false
var offset
var winSize
var ship

onready var stuff = $ZKYStuff/stuff


func _ready():
	CurrentGame.connect("playerShipChanged", self, "setPlayerShip")
	add_to_group("ZKYSettings")
	updateSettings()
	rect_size = Vector2(0, 0)


func setPlayerShip():
	ship = CurrentGame.getPlayerShip()
	get_tree().call_group("ZKYTools", "setShip", ship)


func updateSettings():
	if Loader.current.name == "Game" and get_parent().get_parent().isPlayerControlled():
		visible = Settings.ZKYConfig["modTesting"]["toolWindow"]
	else:
		visible = false


func _input(event):
	if held and event is InputEventMouseMotion:
		rect_position = get_global_mouse_position() - offset
	elif resize and event is InputEventMouseMotion:
		rect_size = get_local_mouse_position() - offset


func _on_moveWindow_pressed():
	held = !held
	offset = get_local_mouse_position()


func _on_minimizeWindow_pressed():
	if stuff.visible:
		stuff.visible = false
		winSize = rect_size
		rect_size = Vector2(0, 0)
	else:
		stuff.visible = true
		rect_size = winSize


func _on_closeWindow_pressed():
	Settings.ZKYConfig["modTesting"]["toolWindow"] = false
	visible = false


func _on_resizeWindow_pressed():
	resize = !resize
	offset = get_local_mouse_position() - rect_size
