extends Area2D

@export var type : String


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("im_pooping"):
		body.im_pooping(type)
