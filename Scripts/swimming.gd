extends Node2D
@onready var rockScene = preload("res://Entities/Screens/rock.tscn")
@onready var rocks: Node2D = $Rocks
@onready var path_follow_2d: PathFollow2D = $Path2D/PathFollow2D
@onready var mini_game_player: CharacterBody2D = $SwimmingMiniGamePlayer
@onready var rock_timer: Timer = $RockTimer
@onready var transition: Node2D = $Transition
@onready var label: Label = $UI/Panel/Label
@onready var coinScene = preload("res://Entities/Objects/coin.tscn")

signal finishedswim
@export var score = 0
var closeMult = 1
var rock


func _ready() -> void:
	Manager.activeScene = "swim"
	transition.leavesopen()
func _process(delta: float) -> void:
	score += delta
	label.text = "Time Spent: " + str(int(score)) + "x" + str(closeMult)
	if mini_game_player == null:
		score *= closeMult
		label.text = "Score: " + str(score) + "!"
		score *= .15

		Manager.SetStats(.15 * score, .7 * score, .15 * score)

		get_tree().paused = true
		transition.leavesclose()
func _on_rock_timer_timeout() -> void:
	var randPos = randf_range(0,1)
	var coinCheck = randi_range(1,10) == 10
	if coinCheck:
		print("MOney")
		rock = coinScene.instantiate()
	else:
		rock = rockScene.instantiate()
	path_follow_2d.progress_ratio = randPos
	rock.global_position = path_follow_2d.global_position
	get_tree().get_root().add_child(rock)

func _on_difficulty_timeout() -> void:
	rock_timer.wait_time -= 0.1
	print(rock_timer.wait_time)


func _on_transition_exited() -> void:
	if not is_connected("finishedswim", Callable(get_parent(), "go_to_days")):
		connect("finishedswim", Callable(get_parent(), "go_to_days"))
		emit_signal("finishedswim")


func _on_swimming_mini_game_player_rock_is_close() -> void:
	closeMult += 1
