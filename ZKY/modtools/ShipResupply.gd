extends Button

export var type = ""
var ship

func _ready():
	add_to_group("ZKYTools")
	connect("pressed", self, "_on_button_pressed")


func setShip(s):
	ship = s


func _on_button_pressed():
	ship[type] = ship[type + "Max"]
