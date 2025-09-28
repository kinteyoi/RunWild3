extends Node2D
@onready var fruitScene: PackedScene = preload("res://Entities/Objects/fruit.tscn")
@onready var fruits: Node2D = $Fruits
@onready var path_follow_2d: PathFollow2D = $Path2D/PathFollow2D
@onready var coconutScene: PackedScene = preload("res://Entities/Objects/fruit.tscn")
@onready var mini_game_player: CharacterBody2D = $MiniGamePlayer
@onready var transition: Node2D = $Transition
@onready var label: Label = $UI/Panel/Label
@onready var label_2: Label = $UI/Panel/Label2

signal finishedrun
var timeLimit = 0

func _ready():
	transition.leavesopen()
	Manager.activeScene = "FruitCollection"

func _process(delta: float) -> void:
	timeLimit += delta
	if timeLimit >= 30 or mini_game_player == null:
		label.text = "Score: " + str(Manager.fruitStats)
		var score = Manager.fruitStats * .1
		Manager.SetStats( .7 * score, .15 * score, .15 * score)
		get_tree().paused = true
		Manager.fruitStats = 0
		transition.leavesclose()
	else:
		label.text = "Score: " + str(Manager.fruitStats)
		label_2.text = "Time Left: " + str(snapped(30 - timeLimit, .01))
func _on_fruit_timer_timeout() -> void:
	var fruitOrCoco = randi_range(0,3) == 1
	var randPos = randf_range(0,1)
	path_follow_2d.progress_ratio = randPos
	if fruitOrCoco:
		var coconut = coconutScene.instantiate()
		coconut.global_position = path_follow_2d.global_position
		fruits.add_child(coconut)
	else:
		var fruit = fruitScene.instantiate()
		fruit.global_position = path_follow_2d.global_position 
		fruits.add_child(fruit)
	


func _on_transition_exited() -> void:
	if not is_connected("finishedrun", Callable(get_parent(), "go_to_days")):
		connect("finishedrun", Callable(get_parent(), "go_to_days"))
		emit_signal("finishedrun")
