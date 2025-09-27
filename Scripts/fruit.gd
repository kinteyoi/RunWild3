extends Area2D

@onready var apple1 = preload("res://Assets/Environment/runwild_apple1.png")
@export var speed = 0


var direction: Vector2 = Vector2.DOWN * 200

func _physics_process(delta: float) -> void:
	position += direction * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _process(delta: float) -> void:
	speed += 1
func _on_body_entered(body: Node2D) -> void:
	Manager.fruitStats += 100
	print(Manager.fruitStats)
	queue_free()
