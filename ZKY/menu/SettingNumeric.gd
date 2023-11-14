extends SpinBox

export var requiresRestart = false
export  var type = ""
export  var setting = ""

func _ready():
	value = Settings.ZKYConfig[type][setting]
	connect("visibility_changed", self, "_on_visibility_changed")
	connect("value_changed", self, "_on_value_changed")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_value_changed(value):
	Settings.ZKYConfig[type][setting] = value


func _on_visibility_changed():
	value = Settings.ZKYConfig[type][setting]
