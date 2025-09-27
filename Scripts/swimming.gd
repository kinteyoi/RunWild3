extends Node2D
@onready var rockScene = preload("res://Entities/Screens/rock.tscn")
@onready var rocks: Node2D = $Rocks
@onready var path_follow_2d: PathFollow2D = $Path2D/PathFollow2D
@onready var mini_game_player: CharacterBody2D = $SwimmingMiniGamePlayer
@onready var rock_timer: Timer = $RockTimer
@onready var transition: Node2D = $Transition
@onready var label: Label = $UI/Panel/Label


signal finished
@export var score = 0


func _ready() -> void:
	Manager.activeScene = "swim"
	transition.leavesopen()
func _process(delta: float) -> void:
	score += delta
	if mini_game_player == null:
		Manager.swimStats = score
		get_tree().paused = true
		transition.leavesclose()
	label.text = "Score: " + str(int(score))
func _on_rock_timer_timeout() -> void:
	var rock = rockScene.instantiate()
	var randPos = randf_range(0,1)
	path_follow_2d.progress_ratio = randPos
	rock.global_position = path_follow_2d.global_position
	get_tree().get_root().add_child(rock)

func _on_difficulty_timeout() -> void:
	rock_timer.wait_time -= 0.1
	print(rock_timer.wait_time)


func _on_transition_exited() -> void:
	emit_signal("finished")
