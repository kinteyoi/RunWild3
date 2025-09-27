extends Area2D
@onready var timer: Timer = $Timer

var cloudCOunt = 0

func _on_body_entered(body: CharacterBody2D) -> void:
	if cloudCOunt > 0:
		body.velocity.y = 0
		body.velocity.y += -1000
		print("boing")
		cloudCOunt -= 1
	else: 
		body.velocity.y = 0
		body.velocity.y += -1000
		Manager.cloudList.pop_front()
		queue_free()


func _on_timer_timeout() -> void:
	pass
