extends CharacterBody2D
var speed: float = 700.0
@export var flyingSpeed: float = 0
@export var swimmingSpeed: float = 0
@export var runningSpeed: float = 0
var gravity_scale = 0
var direction: Vector2 = Vector2.RIGHT
var mode : String
var check = false
@onready var pose: Sprite2D = $Pose
@onready var swim_time: Timer = $SwimTime
@onready var checker: Timer = $checker
var checker2 = true

@onready var deerguy = preload("res://Assets/Players/DeerDog/Kritter_Side_1.png")
@onready var snekguy = preload("res://Assets/Players/Snakegon/Kritter2_Adult_Side.png")
@onready var penguy = preload("res://Assets/Players/PengGon/runwild_birdadultside.png")


func im_pooping(type):
	if type == "fly":
		check = true
		checker.start()
		mode = "fly"
	if type == "swim":
		pose.global_position.y += 400
		checker2 = false
		check = true
		checker.start()
		#velocity.y += 200
		swim_time.start()
	
	
	
	
func _ready() -> void:
	match Manager.current_pet:
		"deergon":
			pose.texture = deerguy
		"penggon":
			pose.texture = penguy
		"snakegon":
			pose.texture = snekguy
		"poopgon":
			pass
		"mongeygon":
			pass
	if Manager.flyStats != 0:
		runningSpeed = Manager.runStats
		swimmingSpeed = Manager.swimStats
		flyingSpeed = Manager.flyStats
	velocity = direction.normalized() * speed

func _physics_process(delta: float) -> void:
	#if not mode == "run":
		#velocity += get_gravity() * delta 
	if is_on_floor() and check == false:
		mode = "run"
		velocity.y = 0
	if mode == "run":
		if !checker2:
			pose.global_position.y -= 400
			checker2 = true
		#print(velocity)
		floor_snap_length = 20
		velocity = direction.normalized() * runningSpeed

	if mode == "fly":
		#print("fly")
		velocity = direction.normalized() * flyingSpeed

		velocity.y = 600
	if mode == "swim":
		#print("swim")
		velocity = direction.normalized() * swimmingSpeed

		velocity.y = 0
	move_and_slide()


func _on_check_timeout() -> void:
	check = false


func _on_swim_time_timeout() -> void:
	mode = "swim"
