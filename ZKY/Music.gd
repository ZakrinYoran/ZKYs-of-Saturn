extends "res://Music.gd"


onready var musicFiles = {
	"mood_battle":$Battle,
	"mood_boss":$Boss,
	"mood_mystery":$Mystery,
	"mood_peaceful":$Peaceful,
	"mood_peaceful_alternate":$Peaceful2,
	"mood_rock":$Rock,
	"mood_spooky":$Spooky,
	"mood_western":$Western,
	"mood_western_alternate":$Western2,
}

func _ready():
	updateMusic()

func updateMusic():
	Debug.l("ZKY: Updating music")
	for track in Settings.ZKYConfig.customMusic:
		var trackPath = Settings.ZKYConfig.customMusic[track]
		if trackPath == "":
			pass
		elif !File.new().file_exists(trackPath):
			Debug.l("ZKY: Error loading custom song %s: File does not exist" % trackPath)
		elif trackPath.get_extension() == "mp3" or trackPath.get_extension() == "ogg":
#			musicFiles[track].stream = load(trackPath)

			Debug.l("ZKY: Updating track: %s <- %s" % [track, trackPath])
		else:
			Debug.l("ZKY: Error loading custom song %s: File type not supported" % trackPath)
	Debug.l("ZKY: Finished updating music")
