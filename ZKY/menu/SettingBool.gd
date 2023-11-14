extends CheckButton

export var requiresRestart = false
export var type = ""
export var setting = ""

func _ready():
	connect("visibility_changed", self, "_on_visibility_changed")
	connect("toggled", self, "_on_button_toggled")


func _on_button_toggled(value):
	Settings.ZKYConfig[type][setting] = value


func _on_visibility_changed():
	pressed = Settings.ZKYConfig[type][setting]
