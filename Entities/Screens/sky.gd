extends Node2D

@onready var mini_game_player: CharacterBody2D = $MiniGamePlayer
@onready var path_2d: Path2D = $Path2D
@onready var path_follow_2d: PathFollow2D = $Path2D/PathFollow2D
@onready var cloudScene: PackedScene = preload("res://Entities/Objects/cloud.tscn")
@onready var clouds: Node2D = $Clouds


func _ready() -> void:
	Manager.cloudList.append($Clouds/Cloud0)
	
func _process(delta: float) -> void:
	path_2d.global_position.y = mini_game_player.global_position.y - 50

	if Manager.cloudList.size() <= Manager.maxClouds:
		AddCloud()
	
func AddCloud():
	var randPos = randf_range(0, 1)
	var cloud = cloudScene.instantiate()
	clouds.add_child(cloud)
	Manager.cloudList.append(cloud)
	path_follow_2d.progress_ratio = randPos
	cloud.position = path_follow_2d.global_position
	if Manager.maxBounce == 1 and Manager.maxClouds == 1:
		return
	else:
		Manager.maxBounce -= 1
		Manager.maxClouds -=1
