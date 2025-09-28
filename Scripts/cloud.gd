extends Area2D

@onready var timer: Timer = $Timer
@onready var obby = preload("res://Assets/Environment/runwild_jumpcloud1.png")
@onready var obby2 = preload("res://Assets/Environment/runwild_jumpcloud2.png")
@onready var coinScene = preload("res://Entities/Objects/coin.tscn")
@onready var sprite_2d: Sprite2D = $Sprite2D


@export var jumpingPower = -1000
var cloudBounces = Manager.maxBounce


func _ready() -> void:
	var obby_graphics = [obby, obby2]
	var random_item = obby_graphics.pick_random()
	sprite_2d.texture = random_item
	timer.wait_time = randf_range(4,7)
	if randi_range(1, 10) == 10:
		print("Money")
		var coin = coinScene.instantiate()
		coin.position.y += position.y - 100
		self.add_child(coin)
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
