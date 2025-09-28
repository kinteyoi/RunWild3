extends CharacterBody2D
var speed: float = 700.0
@export var flyingSpeed: float = 0
@export var swimmingSpeed: float = 0
@export var runningSpeed: float = 0
var gravity_scale = 0
var direction: Vector2 = Vector2.RIGHT
var mode : String
var check = false
@onready var swim_time: Timer = $SwimTime
@onready var checker: Timer = $checker

@onready var label: Label = $Label



func im_pooping(type):
	if type == "fly":
		check = true
		checker.start()
		mode = "fly"
	if type == "swim":
		check = true
		checker.start()
		velocity.y += 200
		swim_time.start()
	
	
	
	
func _ready() -> void:
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
		#print(velocity)
		floor_snap_length = 20
		velocity = direction.normalized() * runningSpeed
		label.text = "Runung Poop"
	if mode == "fly":
		#print("fly")
		velocity = direction.normalized() * flyingSpeed
		label.text = "Flyung Poop"
		velocity.y = 600
	if mode == "swim":
		#print("swim")
		velocity = direction.normalized() * runningSpeed
		label.text = "Swimung Poop"
		velocity.y = 0
	move_and_slide()


func _on_check_timeout() -> void:
	check = false


func _on_swim_time_timeout() -> void:
	mode = "swim"
