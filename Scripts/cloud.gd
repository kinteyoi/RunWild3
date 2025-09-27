extends Area2D
@onready var timer: Timer = $Timer

var cloudBounces = Manager.maxBounce
func _on_body_entered(body: CharacterBody2D) -> void:
	if cloudBounces > 0:
		body.velocity.y = 0
		body.velocity.y += -1000
		cloudBounces -= 1
		timer.start()
	else:
		body.velocity.y = 0
		body.velocity.y += -1000
		Manager.cloudList.pop_front()
		queue_free()


func _on_timer_timeout() -> void:
	Manager.cloudList.pop_at(Manager.cloudList.find(self))
	queue_free()
