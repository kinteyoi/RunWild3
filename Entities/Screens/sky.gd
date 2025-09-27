extends Node2D

@onready var path_follow_2d: PathFollow2D = $MiniGamePlayer/Path2D/PathFollow2D
@onready var cloudScene: PackedScene = preload("res://Entities/Objects/cloud.tscn")
@onready var clouds: Node2D = $Clouds


func _ready() -> void:
	Manager.cloudList.append($Clouds/Cloud0)
	
func _process(delta: float) -> void:
	if Manager.cloudList.size() == 0:
		AddCloud()
	
func AddCloud():
	var randPos = randf_range(0, 1)
	var cloud = cloudScene.instantiate()
	clouds.add_child(cloud)
	Manager.cloudList.append(cloud)
	path_follow_2d.progress_ratio = randPos
	cloud.position = path_follow_2d.global_position
