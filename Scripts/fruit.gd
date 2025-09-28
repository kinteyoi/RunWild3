extends CharacterBody2D

@onready var apple1 = preload("res://Assets/Environment/runwild_apple1.png")
@onready var apple2 = preload("res://Assets/Environment/runwild_apple2.png")
@onready var apple3 = preload("res://Assets/Environment/runwild_appleEVIL.png")
@onready var apple4 = preload("res://Assets/UI/StopWatch.png")
@export var speed = 1
var time_factor = 1
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var area_2d: Area2D = $Area2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var evil: AudioStreamPlayer2D = $evil
var is_evil = false
var is_good = false
var direction: Vector2 = Vector2.DOWN
var app_graphics = []
func _ready() -> void:
	var rand_pickup = randf_range(0, 1)
	if rand_pickup >= .9:
		var app_graphics = [apple4]
		var random_item = app_graphics.pick_random()
		if random_item == apple3:
			is_evil = true
		if random_item == apple4:
			is_good = true
		sprite_2d.texture = random_item
	else:
		var app_graphics = [apple1, apple2, apple3]
		var random_item = app_graphics.pick_random()
		if random_item == apple3:
			is_evil = true
		if random_item == apple4:
			is_good = true
		sprite_2d.texture = random_item

func _physics_process(delta: float) -> void:
	pass
	speed = speed + time_factor
	move_and_collide(velocity * delta)

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _process(delta: float) -> void:
	velocity = direction.normalized() * speed

func _on_area_2d_body_entered(body: Node2D) -> void:
	if is_evil:
		print("ouch")
		body.hit()
		Manager.fruitStats -= 100
		evil.play()
	elif is_good:
		body.kiss()
	else:
		Manager.fruitStats += 100
		audio_stream_player_2d.play()
	sprite_2d.visible = false
	area_2d.monitoring = false


func _on_timer_timeout() -> void:
	time_factor += 1


func _on_audio_stream_player_2d_finished() -> void:
	queue_free()


func _on_evil_finished() -> void:
	queue_free()
