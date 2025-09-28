extends CharacterBody2D
@onready var pose: Sprite2D = $Pose
@onready var action_timer: Timer = $ActionTimer
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var ray_cast_2d_2: RayCast2D = $RayCast2D2

#DEERDOG

@onready var dogside = preload("res://Assets/Players/DeerDog/Kritter1_adultback8.png")
@onready var dogsideevo2 = preload("res://Assets/Players/DeerDog/Kritter1_adultback5.png")
@onready var dogsideevo3 = preload("res://Assets/Players/DeerDog/Kritter1_adultback2.png")

@onready var dog = preload("res://Assets/Players/DeerDog/Kritter1_adultback6.png")
@onready var dogevo2 = preload("res://Assets/Players/DeerDog/Kritter1_adultback3.png")
@onready var dogevo3 = preload("res://Assets/Players/DeerDog/Kritter1_adultback.png")
#PENGGON












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
		change_dir("left")
	if collider2 and collider2.has_method("wall"):
		direction = Vector2.RIGHT
		change_dir("right")
	if Manager.is_food_active:
		speed = 150
	move_and_collide(velocity * delta)

func _on_action_timer_timeout() -> void:
	if !Manager.is_food_active:
		print("new action")
		var rand_dir = randi_range(0, 1)
		if rand_dir == 0:
			direction = Vector2.LEFT
			change_dir("left")
		else:
			direction = Vector2.RIGHT
			change_dir("right")
		var randspeedy = randi_range(40, 60)
		speed = randspeedy
		var randact = randi_range(0, 3)
		print(randact)
		var randinterval = randi_range(4, 8)
		action_timer.wait_time = randinterval
		if randact == 0:
			speed = 0
			pose.scale.x = 0.485
			match Manager.current_pet:
					"deerdog":
						match Manager.evo:
							1:
								pose.texture = dog
							2:
								pose.texture = dogevo2
							3:
								pose.texture = dogevo3
					"penggon":
						pass
					"poopgon":
						pass
					"mongeygon":
						pass
					"snakegon":
						pass
		elif randact == 1:
			speed += 30
		elif randact == 2:
			speed += 30
		else:
			var randspeed = randi_range(10, 700)
			speed = randspeed
			

func change_dir(dir):
	print(Manager.current_pet)
	print(Manager.evo)
	match dir:
		"left":
			if Manager.evo == 1:
				match Manager.current_pet:
					"deerdog":
						pose.scale.x = -0.485
						pose.texture = dogside
						print("LEFTTTTT")
					"penggon":
						pass
					"poopgon":
						pass
					"mongeygon":
						pass
					"snakegon":
						pass
			elif Manager.evo == 2:
				match Manager.current_pet:
					"deerdog":
						pose.scale.x = -0.485
						pose.texture = dogsideevo2
					"penggon":
						pass
					"poopgon":
						pass
					"mongeygon":
						pass
					"snakegon":
						pass
			else:
				match Manager.current_pet:
					"deerdog":
						pose.scale.x = -0.485
						pose.texture = dogsideevo3
					"penggon":
						pass
					"poopgon":
						pass
					"mongeygon":
						pass
					"snakegon":
						pass
		"right":
			if Manager.evo == 1:
				match Manager.current_pet:
					"deerdog":
						pose.texture = dogside
					"penggon":
						pass
					"poopgon":
						pass
					"mongeygon":
						pass
					"snakegon":
						pass
			elif Manager.evo == 2:
				match Manager.current_pet:
					"deerdog":
						pose.texture = dogsideevo2
					"penggon":
						pass
					"poopgon":
						pass
					"mongeygon":
						pass
					"snakegon":
						pass
			else:
				match Manager.current_pet:
					"deerdog":
						pose.texture = dogsideevo3
					"penggon":
						pass
					"poopgon":
						pass
					"mongeygon":
						pass
					"snakegon":
						pass
