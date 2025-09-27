extends Node2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var jump: AnimationPlayer = $Jump
@onready var button: Button = $Button
@onready var cutscene: AnimationPlayer = $Cutscene
@onready var ray_1: ColorRect = $Egg/Ray1
@onready var ray_2: ColorRect = $Egg/Ray2
@onready var ray_3: ColorRect = $Egg/Ray3


@onready var egg1 = preload("res://Assets/Eggs/runwild_egg1.png")
@onready var egg2 = preload("res://Assets/Eggs/runwild_egg2green.png")
@onready var egg3 = preload("res://Assets/Eggs/runwild_egg3purple.png")
@onready var egg4 = preload("res://Assets/Eggs/runwild_egg4blue.png")
@onready var egg5 = preload("res://Assets/Eggs/runwild_egg5orange.png")
@onready var egg: Sprite2D = $Egg
var hatching = false
var amount_pressed = 0
func _ready() -> void:
	var eggs = [egg1, egg2, egg3, egg4, egg5]
	var random_item = eggs.pick_random()
	egg.texture = random_item
	wiggle()

func _on_wiggle_timeout() -> void:
	wiggle()
func wiggle():
	if !hatching:
		var rand_anim = randi_range(0, 1)
		var rand_speed = randf_range(.8, 2)
		animation_player.speed_scale = rand_speed
		if rand_anim == 0:
			animation_player.play("Wiggle")
		else:
			animation_player.play("WiggleOther")


func _on_timer_timeout() -> void:
	if !hatching:
		jumping()
	
func jumping():
	jump.play("Jump")


func _on_button_pressed() -> void:
	if amount_pressed == 0:
		print("pressed")
		hatching = true
		animation_player.play("WiggleMax")
		cutscene.play("Cutscene")
		amount_pressed += 1
	elif amount_pressed == 1:
		ray_2.visible = true
		amount_pressed += 1
	elif amount_pressed == 2:
		ray_3.visible = true
		amount_pressed += 1
	else:
		
	
