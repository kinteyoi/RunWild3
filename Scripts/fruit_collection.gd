extends Node2D
@onready var fruitScene = preload("res://Entities/Objects/fruit.tscn")
@onready var coconutScene = preload("res://Entities/Objects/fruit.tscn")
@onready var coinScene = preload("res://Entities/Objects/coin.tscn")
@onready var fruits: Node2D = $Fruits
@onready var path_follow_2d: PathFollow2D = $Path2D/PathFollow2D
@onready var mini_game_player: CharacterBody2D = $MiniGamePlayer
@onready var transition: Node2D = $Transition
@onready var label: Label = $UI/Panel/Label
@onready var label_2: Label = $UI/Panel/Label2
@onready var fruit_timer: Timer = $FruitTimer

signal finishedrun
var timer = 0
var timerLimit = 30
var coconut
var apple_factor = 1

func _ready():
	transition.leavesopen()
	Manager.activeScene = "FruitCollection"

func _process(delta: float) -> void:
	timer += delta
	if timer >= timerLimit or mini_game_player == null:
		label.text = "Score: " + str(Manager.fruitStats)
		var score = Manager.fruitStats * .1
		Manager.SetStats( .7 * score, .15 * score, .15 * score)
		get_tree().paused = true
		Manager.fruitStats = 0
		transition.leavesclose()
	else:
		label.text = "Score: " + str(Manager.fruitStats)
		label_2.text = "Time Left: " + str(snapped(timerLimit - timer, .01))
func _on_fruit_timer_timeout() -> void:
	apple_factor += .1
	for i in apple_factor:
		await get_tree().create_timer(.2).timeout
		#fruit_timer.wait_time -= .03
		print(fruit_timer.wait_time)
		var fruitOrCoco = randi_range(0,4) == 1
		var randPos = randf_range(0,1)
		var fruit
		path_follow_2d.progress_ratio = randPos
		if fruitOrCoco:
			if randi_range(0,2) == 1:
				print("MOney")
				fruit = coinScene.instantiate()
			else:
				fruit = coconutScene.instantiate()
		else:
			fruit = fruitScene.instantiate()
		fruit.global_position = path_follow_2d.global_position 
		get_tree().get_root().add_child(fruit)
	


func _on_transition_exited() -> void:
	if not is_connected("finishedrun", Callable(get_parent(), "go_to_days")):
		connect("finishedrun", Callable(get_parent(), "go_to_days"))
		emit_signal("finishedrun")
