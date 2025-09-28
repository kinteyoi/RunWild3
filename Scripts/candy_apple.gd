extends RigidBody2D

func _ready() -> void:
	Manager.is_food_active = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("poop"):
		Manager.is_food_active = false
		queue_free()
