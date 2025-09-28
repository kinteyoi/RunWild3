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
var maxBounce = 2
var defaultMaxClouds = 4
var defaultMaxBounce = 2
# FRUIT SCENE STATS
@export var fruitStats = 0
# PLAYER STATS
var energy = 100
var currency = 0
@export var swimStats = 0
@export var runStats = 0
@export var flyStats = 0

func SetStats(newRunStat, newSwimStat, newFlyStat):
	if energy >= 90:
		var mult = 2
		runStats += newRunStat * mult
		swimStats += newSwimStat * mult
		flyStats += newFlyStat * mult
	elif energy < 90 and energy >= 20:
		runStats += newRunStat 
		swimStats += newSwimStat
		flyStats += newFlyStat
	else:
		var mult = .5
		runStats += newRunStat * mult
		swimStats += newSwimStat * mult
		flyStats += newFlyStat * mult
