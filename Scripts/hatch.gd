extends Node2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var jump: AnimationPlayer = $Jump


@onready var egg1 = preload("res://Assets/Eggs/runwild_egg1.png")
@onready var egg2 = preload("res://Assets/Eggs/runwild_egg2green.png")
@onready var egg3 = preload("res://Assets/Eggs/runwild_egg3purple.png")
@onready var egg4 = preload("res://Assets/Eggs/runwild_egg4blue.png")
@onready var egg5 = preload("res://Assets/Eggs/runwild_egg5orange.png")
@onready var egg: Sprite2D = $Egg

func _ready() -> void:
	var eggs = [egg1, egg2, egg3, egg4, egg5]
	var random_item = eggs.pick_random()
	egg.texture = random_item
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
