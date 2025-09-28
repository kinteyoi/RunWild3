extends Node
var activeScene : String
var days_left = 15
#Current Pet
var current_pet : String = "deergon"
var evo = 0
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
@export var swimStats = 0
@export var runStats = 0
@export var flyStats = 0

func SetStats(newRunStat, newSwimStat, newFlyStat):
	runStats = newRunStat
	swimStats = newSwimStat
	flyStats = newFlyStat
