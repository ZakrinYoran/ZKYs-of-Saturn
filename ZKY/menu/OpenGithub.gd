extends Button


func _ready():
	connect("pressed", self, "_on_button_pressed")


func _on_button_pressed():
	OS.shell_open("https://github.com/ZakrinYoran/ZKYs-of-Saturn/tree/main")
