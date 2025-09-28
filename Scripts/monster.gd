extends CharacterBody2D
var speed: float = 999.0
var gravity_scale = 0
var direction: Vector2 = Vector2.RIGHT
var mode : String
var check = false
@export var flyingSpeed: float = 1100
@export var swimmingSpeed: float = 800
@export var runningSpeed: float = 500
@export var monster : bool = false
@onready var swim_time: Timer = $SwimTime
@onready var checker: Timer = $checker
@onready var panel: Panel = $"../RunnerPet/Camera2D/GG/Panel"


func busting():
	pass


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
	if mode == "fly":
		#print("fly")
		velocity = direction.normalized() * flyingSpeed

		velocity.y = 600
	if mode == "swim":
		#print("swim")
		velocity = direction.normalized() * swimmingSpeed

		velocity.y = 0
	move_and_slide()
	
func Death():
	panel.visible = true
	get_tree().paused = true


func _on_check_timeout() -> void:
	check = false


func _on_swim_time_timeout() -> void:
	mode = "swim"


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("im_pooping"):
		Death()
