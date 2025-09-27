extends Area2D

@export var speed = 100
var direction: Vector2 = Vector2.DOWN * 200
# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += direction * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_body_entered(body) -> void:
	print("ehaw")
	body.queue_free()
