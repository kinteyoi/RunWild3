extends CharacterBody2D

@onready var apple1 = preload("res://Assets/Environment/runwild_apple1.png")
@onready var apple2 = preload("res://Assets/Environment/runwild_apple2.png")
@export var speed = 1
@onready var sprite_2d: Sprite2D = $Sprite2D

var direction: Vector2 = Vector2.DOWN

func _ready() -> void:
	var app_graphics = [apple1, apple2]
	var random_item = app_graphics.pick_random()
	sprite_2d.texture = random_item

func _physics_process(delta: float) -> void:
	pass
	speed = speed + 1
	move_and_collide(velocity * delta)

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _process(delta: float) -> void:
	velocity = direction.normalized() * speed
	print(speed)

func _on_area_2d_body_entered(body: Node2D) -> void:
	Manager.fruitStats += 100
	print(Manager.fruitStats)
	queue_free()
