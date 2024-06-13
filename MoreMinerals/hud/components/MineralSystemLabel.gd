extends Node

func _ready():
	get_child(0).connect("pressed", get_parent(), "toggleRow", [self])
