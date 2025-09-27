extends Area2D


@export var speed = 200
var canMove = false

func _physics_process(delta: float) -> void:
	if canMove:
		position += Vector2.UP * speed * delta

func _on_body_entered(_body: Node2D) -> void:
	Engine.time_scale = 0 
	print("dead")


func _on_timer_timeout() -> void:
	canMove = true
	print("moving")
