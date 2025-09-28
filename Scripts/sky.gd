extends Node2D

@onready var mini_game_player: CharacterBody2D = $MiniGamePlayer
@onready var path_2d: Path2D = $Path2D
@onready var path_follow_2d: PathFollow2D = $Path2D/PathFollow2D
@onready var cloudScene = preload("res://Entities/Objects/cloud.tscn")
@onready var clouds: Node2D = $Clouds
@onready var sub_maxes: Area2D = $DifficultyBarriers/SubMaxes
@onready var sub_maxes_2: Area2D = $DifficultyBarriers/SubMaxes2
@onready var camera_2d: Camera2D = $Camera2D
@onready var label: Label = $Camera2D/UI/Panel/Label
@onready var marker_2d: Marker2D = $Marker2D
@onready var transition: Node2D = $Camera2D/Transition
@onready var timeout: AudioStreamPlayer2D = $Timeout
@onready var star_mode: Area2D = $DifficultyBarriers/StarMode


@export var minXToWrap = -700
@export var maxXToWrap = 2100
@export var ratio = 1050
var playerUp = false
var maxHeight = 0
var score = 0

signal finishedfly

func _ready() -> void:
	transition.leavesopen()
	Manager.activeScene = "sky"
	Manager.cloudList.append($Clouds/Cloud0)
	Manager.cloudList.append($Clouds/Cloud1)
	Manager.cloudList.append($Clouds/Cloud2)
	Manager.cloudList.append($Clouds/Cloud3)
	print(Manager.cloudList.size())
	
func _process(_delta: float) -> void:

	camera_2d.position.y = mini_game_player.position.y
	path_2d.global_position.y = mini_game_player.global_position.y
	mini_game_player.position.x = wrapf(mini_game_player.position.x, minXToWrap, maxXToWrap)
	if mini_game_player.position.y < marker_2d.position.y and playerUp and Engine.time_scale != 0:
		marker_2d.position = mini_game_player.position
		maxHeight = marker_2d.position.y
	score = maxHeight * -.1
	
	label.text = "Score: " + str(int(score))

	if Manager.cloudList.size() < Manager.maxClouds:
		AddCloud()
	
func AddCloud():
	var left = randi_range(0,1) == 1
	var randPos = randf_range(0, .5)
	var cloud = cloudScene.instantiate()
	clouds.add_child(cloud)
	Manager.cloudList.append(cloud)
	path_follow_2d.progress_ratio = mini_game_player.position.x
	var playerPos = path_follow_2d.progress_ratio
	if left:
		randPos = -randPos
	path_follow_2d.progress_ratio = playerPos + randPos
	cloud.position = path_follow_2d.global_position

func Difficulty():
	Manager.maxBounce -= 1
	Manager.maxClouds -= 1
	Manager.maxCloudTimer -= 1
	Manager.minCLoudTimer -= 1
	print("entered New Max")
	print("Max Bounce " + str(Manager.maxBounce))
	print("Max Cloud " + str(Manager.maxClouds))


func _on_sub_maxes_body_entered(_body: Node2D) -> void:
	Difficulty()
	sub_maxes.queue_free()
	

	
func _on_sub_maxes_2_body_entered(_body: Node2D) -> void:
	Difficulty()
	sub_maxes_2.queue_free()

func _on_star_mode_body_entered(_body: Node2D) -> void:
	Difficulty()
	star_mode.queue_free()

func _on_kill_box_body_entered(_body: Node2D) -> void:
	label.text = "Score: " + str(int(score))
	maxHeight *= -0.2
	Manager.maxBounce = 2
	Manager.maxClouds = 4
	Manager.maxCloudTimer = 10
	Manager.minCLoudTimer = 4
	Manager.SetStats(.15 * score, .15 * score, .7 * score)
	maxHeight = 0
	Manager.cloudList.clear()
	get_tree().paused = true
	timeout.play()
	await get_tree().create_timer(1.5).timeout
	transition.leavesclose()


func _on_mini_game_player_up() -> void:
	playerUp = true


func _on_mini_game_player_down() -> void:
	playerUp = false


func _on_transition_exited() -> void:
	if not is_connected("finishedfly", Callable(get_parent(), "go_to_days")):
		connect("finishedfly", Callable(get_parent(), "go_to_days"))
		emit_signal("finishedfly")


func _on_kill_box_area_entered(area: Area2D) -> void:
	Manager.cloudList.pop_at(Manager.cloudList.find(self))
	area.queue_free()


	
