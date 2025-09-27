extends Node2D
@onready var rockScene: PackedScene = preload("res://Entities/Screens/rock.tscn")
@onready var rocks: Node2D = $Rocks
@onready var path_follow_2d: PathFollow2D = $Path2D/PathFollow2D
@onready var mini_game_player: CharacterBody2D = $MiniGamePlayer

func _process(delta: float) -> void:
	if mini_game_player == null:
		Engine.time_scale = 0

func _on_rock_timer_timeout() -> void:
	var rock = rockScene.instantiate()
	var randPos = randf_range(0,1)
	path_follow_2d.progress_ratio = randPos
	rock.global_position = path_follow_2d.global_position
	rocks.add_child(rock)
