extends Node2D

@onready var mini_game_player: CharacterBody2D = $MiniGamePlayer
@onready var path_2d: Path2D = $Path2D
@onready var path_follow_2d: PathFollow2D = $Path2D/PathFollow2D
@onready var cloudScene: PackedScene = preload("res://Entities/Objects/cloud.tscn")
@onready var clouds: Node2D = $Clouds
@onready var sub_maxes: Area2D = $DifficultyBarriers/SubMaxes
@onready var sub_maxes_2: Area2D = $DifficultyBarriers/SubMaxes2
@onready var camera_2d: Camera2D = $Camera2D

@export var minXToWrap = -700
@export var maxXToWrap = 2100
@export var ratio = 1050

var maxHeight = 0

func _ready() -> void:
	Manager.cloudList.append($Clouds/Cloud0)
	Manager.cloudList.append($Clouds/Cloud1)
	Manager.cloudList.append($Clouds/Cloud2)
	Manager.cloudList.append($Clouds/Cloud3)
	
func _process(_delta: float) -> void:
	camera_2d.position.y = mini_game_player.position.y
	path_2d.global_position.y = mini_game_player.global_position.y - 30
	mini_game_player.position.x = wrapf(mini_game_player.position.x, minXToWrap, maxXToWrap)
	
	if Engine.time_scale != 0 and maxHeight < mini_game_player.position.y:
		maxHeight = mini_game_player.position.y

	if Manager.cloudList.size() < Manager.maxClouds:
		AddCloud()
	
func AddCloud():
	var randPos = randf_range(0, .15)
	var cloud = cloudScene.instantiate()
	clouds.add_child(cloud)
	Manager.cloudList.append(cloud)
	path_follow_2d.progress_ratio = randPos + mini_game_player.position.x/ratio
	cloud.position = path_follow_2d.global_position




func _on_sub_maxes_body_entered(_body: Node2D) -> void:
	Manager.maxBounce -= 1
	Manager.maxClouds -= 1
	print("entered New Max")
	print("Max Bounce " + str(Manager.maxBounce))
	print("Max Cloud " + str(Manager.maxClouds))
	sub_maxes.queue_free()
	#print($"Max Bounce: {Manager.maxBounce}, Max Clouds: {Manager.maxClouds}")


func _on_sub_maxes_2_body_entered(_body: Node2D) -> void:
	Manager.maxBounce -= 1
	Manager.maxClouds -= 1
	print("entered New Max")
	print("Max Bounce " + str(Manager.maxBounce))
	print("Max Cloud " + str(Manager.maxClouds))
	sub_maxes_2.queue_free()


func _on_kill_box_body_entered(body: Node2D) -> void:
	if body.has_method("_on_timer_timeout()"):
		Manager.cloudList.pop_at(Manager.cloudList.find(self))
		body.queue_free()
		print("snapCracklePop")
	else:
		maxHeight *= .1
		print(int(maxHeight))
		Manager.cloudStats = int(maxHeight)
		Engine.time_scale = 0
