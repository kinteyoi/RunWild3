extends Area2D
@onready var timer: Timer = $Timer
@export var jumpingPower = -1000
var cloudBounces = Manager.maxBounce

func _ready() -> void:
	timer.wait_time = randf_range(3,5)
func _on_body_entered(body: CharacterBody2D) -> void:
	if cloudBounces > 0:
		body.velocity.y = 0
		body.velocity.y += jumpingPower
		cloudBounces -= 1
		timer.start()
	else:
		body.velocity.y = 0
		body.velocity.y += jumpingPower
		Manager.cloudList.pop_at(Manager.cloudList.find(self))
		queue_free()


func _on_timer_timeout() -> void:
	Manager.cloudList.pop_at(Manager.cloudList.find(self))
	queue_free()
