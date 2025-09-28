extends CharacterBody2D
@onready var kritter_1_adultback_7: Sprite2D = $Kritter1Adultback7
@onready var action_timer: Timer = $ActionTimer
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var ray_cast_2d_2: RayCast2D = $RayCast2D2

var speed: float = 0
var direction: Vector2 = Vector2.RIGHT

func poop():
	pass

func _ready() -> void:
	velocity = direction.normalized() * speed

func _physics_process(delta: float) -> void:
	velocity = direction.normalized() * speed
	var collider = ray_cast_2d.get_collider()
	var collider2 = ray_cast_2d_2.get_collider()
	if collider and collider.has_method("wall"):
		direction = Vector2.LEFT
	if collider2 and collider2.has_method("wall"):
		direction = Vector2.RIGHT
	if Manager.is_food_active:
		speed = 150
	move_and_collide(velocity * delta)

func _on_action_timer_timeout() -> void:
	if !Manager.is_food_active:
		print("new action")
		var rand_dir = randi_range(0, 1)
		if rand_dir == 0:
			direction = Vector2.LEFT
		else:
			direction = Vector2.RIGHT
		var randspeedy = randi_range(40, 60)
		speed = randspeedy
		var randact = randi_range(0, 3)
		print(randact)
		var randinterval = randi_range(4, 8)
		action_timer.wait_time = randinterval
		if randact == 0:
			speed = 0
		elif randact == 1:
			speed += 30
		elif randact == 2:
			speed += 30
		else:
			var randspeed = randi_range(10, 700)
			speed = randspeed
