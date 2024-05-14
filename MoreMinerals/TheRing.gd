extends "res://TheRing.gd"

#Modified function to support more than 8 mineral types
func getVeinAt(pos)->String:
	var p1 = getVeinPixelAt(pos / 1861.0)
	var p2 = getVeinPixelAt(pos / - 2531.0)
	var p3 = getVeinPixelAt(pos / 1337.0)

	var values = [p1.r, p1.g, p1.b, p1.a, p2.r, p2.b, p2.g, p2.a, p3.r, p3.b, p3.g, p3.a]

	var total = 0
	for n in range(CurrentGame.traceMinerals.size()):
		var tm = CurrentGame.traceMinerals[n]
		values[n] = pow(values[n] / pow(CurrentGame.mineralPrices.get(tm, 1), 0.2), 4)
		total += values[n]

	var rnd = randf() * total
	var nr = 0
	for n in values:
		rnd -= n
		if rnd < 0:
			return CurrentGame.traceMinerals[nr]
		nr += 1

	return CurrentGame.traceMinerals[0]
