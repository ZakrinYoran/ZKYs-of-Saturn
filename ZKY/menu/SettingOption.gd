extends OptionButton

export var requiresRestart = false
export  var type = ""
export  var setting = ""
export  var modes = {}

var lut = {}

func _ready():
	fillInModes()
	connect("visibility_changed", self, "_on_visibility_changed")
	connect("item_selected", self, "_on_item_selected")


func _on_item_selected(id):
	Settings.ZKYConfig[type][setting] = modes.keys()[id]


func _on_visibility_changed():
	fillInModes()


func fillInModes():
	clear()
	var nr = 0
	for mode in modes:
		add_item(modes[mode])
		lut[mode] = nr
		nr += 1
	var mode = Settings.ZKYConfig[type][setting]
	selected = lut[mode]
