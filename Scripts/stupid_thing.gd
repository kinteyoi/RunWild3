extends CharacterBody2D
@onready var pose: Sprite2D = $Pose
@onready var action_timer: Timer = $ActionTimer
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var ray_cast_2d_2: RayCast2D = $RayCast2D2
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var babbydog = preload("res://Assets/Players/DeerDog/Kritter1_adultback6.png")
@onready var meddog = preload("res://Assets/Players/DeerDog/Kritter1_adultback3.png")
@onready var bigdog = preload("res://Assets/Players/DeerDog/Kritter1_adultback.png")

@onready var pengon = preload("res://Assets/Players/PengGon/runwild_birdbaby.png")
@onready var pengon2 = preload("res://Assets/Players/PengGon/runwild_birdteenfront.png")
@onready var pengon3 = preload("res://Assets/Players/PengGon/runwild_birdadultfront.png")

@onready var snekgon = preload("res://Assets/Players/Snakegon/Kritter2_Baby.png")
@onready var snekgon2 = preload("res://Assets/Players/Snakegon/Kritter2_Teen.png")
@onready var snekgon3 = preload("res://Assets/Players/Snakegon/Kritter2_Adult_Front.png")

var speed: float = 0
var direction: Vector2 = Vector2.RIGHT

func poop():
	pass

func _ready() -> void:
	match Manager.current_pet:
		"deergon":
			match Manager.evo:
				1:
					pose.texture = babbydog
				2:
					pose.texture = meddog
				3:
					pose.texture = bigdog
		"penggon":
			match Manager.evo:
				1:
					pose.texture = pengon
				2:
					pose.texture = pengon2
				3:
					pose.texture = pengon3
		"snakegon":
			match Manager.evo:
				1:
					pose.texture = snekgon
				2:
					pose.texture = snekgon2
				3:
					pose.texture = snekgon3
		"poopgon":
			match Manager.evo:
				1:
					pass
				2:
					pass
				3:
					pass
		"mongeygon":
			match Manager.evo:
				1:
					pass
				2:
					pass
				3:
					pass
	velocity = direction.normalized() * speed

func _physics_process(delta: float) -> void:
	if speed > 0:
		animation_player.play("walk")
	else:
		animation_player.play("RESET")
		
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
