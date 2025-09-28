extends Node
var activeScene : String
var days_left = 16
#Current Pet
var current_pet : String = "deergon"

var evo = 1
var base_drain = 30
var affinity_drain = 15
var is_food_active = false
#Cloud Scene
var cloudList = []
var maxClouds = 4
var maxBounce = 3
var maxCloudTimer = 6
var minCLoudTimer = 4
# FRUIT SCENE STATS
@export var fruitStats = 0
# PLAYER STATS
var energy = 100
var currency = 0
@export var swimStats = 0
@export var runStats = 0
@export var flyStats = 0

var mult
var maxScore = 100
func SetStats(newRunStat, newSwimStat, newFlyStat):
	if energy >= 90:
		mult = 2
	elif energy < 90 and energy >= 20:
		mult = 1
	else:
		mult = .5
	if newRunStat > maxScore:
		runStats += maxScore
		swimStats += newSwimStat * mult
		flyStats += newFlyStat * mult
		
	elif newSwimStat > maxScore:
		runStats += newRunStat * mult
		swimStats += maxScore
		flyStats += newFlyStat * mult
		
	elif newFlyStat > maxScore:
		runStats += newRunStat * mult
		swimStats += newSwimStat * mult
		flyStats += maxScore
	else:
		runStats += newRunStat * mult
		swimStats += newSwimStat * mult
		flyStats += newFlyStat * mult
