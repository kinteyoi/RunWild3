extends Area2D

@export var speed = 200
var canMove = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if canMove:
		position.y += -speed * delta


func _on_kill_box_delay_timeout() -> void:
	canMove = true
	print("moving")
