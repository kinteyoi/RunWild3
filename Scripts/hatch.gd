extends Node2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var jump: AnimationPlayer = $Jump

func _ready() -> void:
	wiggle()

func _on_wiggle_timeout() -> void:
	wiggle()
func wiggle():
	var rand_anim = randi_range(0, 1)
	var rand_speed = randf_range(.8, 2)
	animation_player.speed_scale = rand_speed
	if rand_anim == 0:
		animation_player.play("Wiggle")
	else:
		animation_player.play("WiggleOther")


func _on_timer_timeout() -> void:
	jumping()
	
func jumping():
	jump.play("Jump")
