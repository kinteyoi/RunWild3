extends CharacterBody2D
var speed: float = 700.0
var gravity_scale = 0
var direction: Vector2 = Vector2.RIGHT
var mode : String
var check = false
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
		mode = "swim"
	
	
	
	
func _ready() -> void:
	pass
	velocity = direction.normalized() * speed

func _physics_process(delta: float) -> void:
	#if not mode == "run":
		#velocity += get_gravity() * delta 
	if is_on_floor() and check == false:
		mode = "run"
		velocity.y = 0
	if mode == "run":
		print("run")
		floor_snap_length = 20
		label.text = "Runung Poop"
	if mode == "fly":
		print("fly")
		label.text = "Flyung Poop"
		velocity.y = 400
	if mode == "swim":
		print("swim")
		label.text = "Swimung Poop"
		velocity.y = 0
	move_and_slide()


func _on_check_timeout() -> void:
	check = false
