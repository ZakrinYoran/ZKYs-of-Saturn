extends LineEdit

export  var type = "input"
export  var setting = ""

func _ready():
	text = Settings.ZKYConfig[type][setting]
	connect("visibility_changed", self, "_on_visibility_changed")
	connect("text_entered", self, "_on_text_entered")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_text_entered(string):
	Settings.ZKYConfig[type][setting] = string

func _on_visibility_changed():
	text = Settings.ZKYConfig[type][setting]
