extends CharacterBody2D

@onready var apple1 = preload("res://Assets/Environment/runwild_apple1.png")
@onready var apple2 = preload("res://Assets/Environment/runwild_apple2.png")
@onready var apple3 = preload("res://Assets/Environment/runwild_appleEVIL.png")
@export var speed = 1
var time_factor = 1
@onready var sprite_2d: Sprite2D = $Sprite2D
var is_evil = false
var direction: Vector2 = Vector2.DOWN

func _ready() -> void:
	var app_graphics = [apple1, apple2, apple3]
	var random_item = app_graphics.pick_random()
	if random_item == apple3:
		is_evil = true
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
	Manager.fruitStats += 100
	queue_free()


func _on_timer_timeout() -> void:
	time_factor += 1
