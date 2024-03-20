extends "res://namer/Namer.gd"


var addedCrew = {}


func _ready():
	if Settings.ZKYConfig["additions"]["addCrewNames"]:
		addCrew()


func addCrew():
	Debug.l("ZKY: Adding additional crew names.")
	var f = File.new()
	f.open("res://ZKY/namer/crew.cs", f.READ)

	var first = true
	while f.get_position() < f.get_len():
		var csv = f.get_line().split(",")
		if csv.size() == 4 and not first:
			if not csv[0] in addedCrew:
				addedCrew[csv[0]] = []
			addedCrew[csv[0]].append([csv[1], csv[2], float(csv[3])])
			names.crew[csv[0]].append([csv[1], csv[2], float(csv[3])])
		first = false
	f.close()

	for group in addedCrew:
		for n in addedCrew[group]:
			if n[2] > 0:
				names.male[group].append(n)
			if n[2] < 1:
				names.female[group].append(n)

	Debug.l("ZKY: Added crew names: %s" % addedCrew)
