extends Node2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var jump: AnimationPlayer = $Jump
@onready var button: Button = $Button
@onready var cutscene: AnimationPlayer = $Cutscene
@onready var ray_1: ColorRect = $Egg/Ray1
@onready var ray_2: ColorRect = $Egg/Ray2
@onready var ray_3: ColorRect = $Egg/Ray3
@onready var cutscene_2: AnimationPlayer = $Cutscene2
@onready var crack2 = preload("res://Assets/Eggs/runwild_eggcrack2.png")
@onready var crack3 = preload("res://Assets/Eggs/runwild_eggcrack3.png")
@onready var egg1 = preload("res://Assets/Eggs/runwild_egg1.png")
@onready var egg2 = preload("res://Assets/Eggs/runwild_egg2green.png")
@onready var egg3 = preload("res://Assets/Eggs/runwild_egg3purple.png")
@onready var egg4 = preload("res://Assets/Eggs/runwild_egg4blue.png")
@onready var egg5 = preload("res://Assets/Eggs/runwild_egg5orange.png")
@onready var egg: Sprite2D = $Egg
@onready var runwild_eggcrackswhite: Sprite2D = $Egg/RunwildEggcrackswhite

@onready var label: Label = $Marker2D/NinePatchRect/Label
@onready var bing: AudioStreamPlayer2D = $Marker2D/Bing
@onready var bing_time: Timer = $Marker2D/BingTime
@onready var kritter: Sprite2D = $Kritter
@onready var transition: Node2D = $Transition
@onready var end: Timer = $End

@onready var marker_2d: Marker2D = $Marker2D

@onready var deerdog = preload("res://Assets/Players/DeerDog/Kritter1_adultback6.png")
@onready var penggon = preload("res://Assets/Players/PengGon/runwild_birdbaby.png")
@onready var poopgon = preload("res://Assets/Players/DeerDog/Kritter1_adultback6.png")
@onready var mongeygon = preload("res://Assets/Players/DeerDog/Kritter1_adultback6.png")
@onready var snakegon = preload("res://Assets/Players/DeerDog/Kritter1_adultback6.png")


@onready var pet_graphs = [deerdog, penggon, poopgon, mongeygon, snakegon]
var available_pets = ["deerdog", "penggon", "poopgon", "mongeygon", "snakegon"]
signal finished

var hatching = false
var amount_pressed = 0
func _ready() -> void:
	var eggs = [egg1, egg2, egg3, egg4, egg5]
	var random_item = eggs.pick_random()
	egg.texture = random_item
	var random_pet = pet_graphs.pick_random()
	var random_pick = available_pets.pick_random()
	kritter.texture = random_pet
	match random_pick:
		"deerdog":
			label.text = "You Hatched DeerGon"
			Manager.current_pet = "deergon"
		"penggon":
			label.text = "You Hatched PengGon"
			Manager.current_pet = "penggon"
		"poopgon":
			label.text = "You Hatched PoopGon"
			Manager.current_pet = "poopgon"
		"mongeygon":
			label.text = "You Hatched MongeyGon"
			Manager.current_pet = "mongeygon"
		"snakegon":
			label.text = "You Hatched SnakeGon"
			Manager.current_pet = "snakegon"
	transition.leavesopen()
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
		animation_player.play("WiggleMax2")
		ray_2.visible = true
		amount_pressed += 1
		runwild_eggcrackswhite.texture = crack2
	elif amount_pressed == 2:
		runwild_eggcrackswhite.texture = crack3
		animation_player.play("WiggleMax3")
		ray_3.visible = true
		amount_pressed += 1
	elif amount_pressed == 3:
		cutscene_2.play("Cutscene2")
		amount_pressed += 1
	else:
		pass
	


func _on_cutscene_2_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Cutscene2":
		cutscene.play("Reverse")
		kritter.visible = true
		marker_2d.visible = true
		bing_time.start()


func _on_bing_time_timeout() -> void:
	if label.visible_ratio <= .99:
		bing.play()
		label.visible_characters += 1
	else:
		print("boi")
		bing_time.stop()
		end.start()


func _on_end_timeout() -> void:
	transition.leavesclose()


func _on_transition_exited() -> void:
	emit_signal("finished")
