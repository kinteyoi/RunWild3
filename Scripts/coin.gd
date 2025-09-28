extends Area2D

var direction: Vector2 = Vector2.DOWN * 200

func _physics_process(delta: float) -> void:
	if Manager.activeScene != "sky":
		position += direction * delta
	else:
		pass

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		Manager.currency += 1
		queue_free()
		
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
