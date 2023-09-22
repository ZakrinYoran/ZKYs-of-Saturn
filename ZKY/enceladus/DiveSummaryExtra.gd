extends Button

var summary
var player


func _ready():
	summary = get_tree().root.find_node("Summary", true, false)
	player = summary.get_node("Player")
	self.connect("pressed", self, "_on_Keep_pressed")


func _on_Keep_pressed():
	if player.is_playing():
		return 

	for est in Tool.multiClaimWhatYouCanAndReturnIt(summary.estimators):
		Debug.l(str(est))
		var item = est.get_parent()
		if "PCC" in item.name:
			pass
		else:
			est.queueSell()
	Tool.multiReleaseGlobal()
	player.play("Vanish")

	var ship = CurrentGame.getPlayerShip()
	ship.emptyUnprocessedCargo()
	summary.refocus()
