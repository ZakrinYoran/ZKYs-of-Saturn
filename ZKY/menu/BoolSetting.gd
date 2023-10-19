extends CheckButton


export  var type = ""
export  var setting = ""

func _ready():
	pressed = Settings.ZKYConfig[type][setting]
	connect("visibility_changed", self, "_on_visibility_changed")
	connect("toggled", self, "_on_button_toggled")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_button_toggled(value):
	Settings.ZKYConfig[type][setting] = value
	get_tree().call_group("ZKYSettings", "updateSettings")

func _on_visibility_changed():
	pressed = Settings.ZKYConfig[type][setting]
