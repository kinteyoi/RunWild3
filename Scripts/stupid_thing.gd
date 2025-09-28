extends CharacterBody2D
@onready var kritter_1_adultback_7: Sprite2D = $Kritter1Adultback7
@onready var action_timer: Timer = $ActionTimer

var speed: float = 0
var direction: Vector2

func poop():
	pass

func _ready() -> void:
	velocity = direction.normalized() * speed

func _physics_process(delta: float) -> void:
	move_and_collide(velocity * delta)

func _on_action_timer_timeout() -> void:
	print("new action")
	var randspeedy = randi_range(40, 60)
	speed = randspeedy
	var randact = randi_range(0, 3)
	print(randact)
	var randinterval = randi_range(4, 8)
	action_timer.wait_time = randinterval
	if randact == 0:
		speed = 0
	elif randact == 1:
		direction = Vector2.RIGHT
		speed += 30
	elif randact == 2:
		direction = Vector2.LEFT
		speed += 30
	else:
		var randspeed = randi_range(10, 700)
		speed = randspeed
	velocity = direction.normalized() * speed
