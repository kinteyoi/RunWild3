extends Node2D
@onready var rockScene: PackedScene = preload("res://Entities/Screens/rock.tscn")
@onready var rocks: Node2D = $Rocks
@onready var path_follow_2d: PathFollow2D = $Path2D/PathFollow2D
@onready var mini_game_player: CharacterBody2D = $MiniGamePlayer
@onready var rock_timer: Timer = $RockTimer

@export var power = 0

func _process(delta: float) -> void:
	power += delta
	if mini_game_player == null:
		Engine.time_scale = 0

func _on_rock_timer_timeout() -> void:
	var rock = rockScene.instantiate()
	var randPos = randf_range(0,1)
	path_follow_2d.progress_ratio = randPos
	rock.global_position = path_follow_2d.global_position
	rocks.add_child(rock)


func _on_difficulty_timeout() -> void:
	rock_timer.wait_time -= 0.1
	print(rock_timer.wait_time)
