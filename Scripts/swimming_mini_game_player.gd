extends CharacterBody2D
#@onready var icon: Sprite2D = $Icon

#DEERGON
@onready var splash = preload("res://Assets/Particles/splash.tscn")

@onready var deer1 = preload("res://Assets/Players/DeerDog/runwild_babyswim.png")
@onready var deer2 = preload("res://Assets/Players/DeerDog/runwild_teenswim.png")
@onready var deer3 = preload("res://Assets/Players/DeerDog/runwild_adultswim.png")

@onready var deerjump = preload("res://Assets/Players/DeerDog/Kritter1_adultback7.png")
@onready var deerjump2 = preload("res://Assets/Players/DeerDog/likufdftgyh.png")
@onready var deerjump3 = preload("res://Assets/Players/DeerDog/dguykaweopl.png")

@onready var pen1 = preload("res://Assets/Players/PengGon/birdbabyswim.png")
@onready var pen2 = preload("res://Assets/Players/PengGon/birdteenswim.png")
@onready var pen3 = preload("res://Assets/Players/PengGon/birdadultswim.png")

@onready var penjump = preload("res://Assets/Players/PengGon/birdbabyswimjump.png")
@onready var penjump2 = preload("res://Assets/Players/PengGon/birdteenswimjump.png")
@onready var penjump3 = preload("res://Assets/Players/PengGon/birdadultswimjump.png")


@onready var snake = preload("res://Assets/Players/Snakegon/runwild_snakeswimbaby.png")
@onready var snake2 = preload("res://Assets/Players/Snakegon/runwild_snakeswimteen.png")
@onready var snake3 = preload("res://Assets/Players/Snakegon/runwild_snakeswimadult.png")

@onready var snakej = preload("res://Assets/Players/Snakegon/Kritter2_swim_baby.png")
@onready var snake2j = preload("res://Assets/Players/Snakegon/Kritter2_swim_teen.png")
@onready var snake3j = preload("res://Assets/Players/Snakegon/Kritter2_back_swim_adult.png")

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

@onready var close_time_limit: Timer = $CloseTimeLimit
@onready var pose: Sprite2D = $Icon
@onready var jump: Timer = $Jump

@onready var speed = 150
var can_jump = true
signal rockIsClose 
func player():
	pass
func _ready() -> void:
	match Manager.current_pet:
		"deergon":
			match Manager.evo:
				1:
					pose.texture = deer1
				2:
					pose.texture = deer2
				3:
					pose.texture = deer3
		"penggon":
			match Manager.evo:
				1:
					pose.texture = pen1
				2:
					pose.texture = pen2
				3:
					pose.texture = pen3
		"snakegon":
			match Manager.evo:
				1:
					pose.texture = snake
				2:
					pose.texture = snake2
				3:
					pose.texture = snake3
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
func _physics_process(_delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * speed
	if Input.is_action_just_pressed("ui_accept"):
		if can_jump:
			set_collision_layer_value(10, false)
			jump.start()
			can_jump = false
			match Manager.current_pet:
				"deergon":
					match Manager.evo:
						1:
							pose.texture = deerjump
						2:
							pose.texture = deerjump2
						3:
							pose.texture = deerjump3
				"penggon":
					match Manager.evo:
						1:
							pose.texture = penjump
						2:
							pose.texture = penjump2
						3:
							pose.texture = penjump3
				"snakegon":
					match Manager.evo:
						1:
							pose.texture = snakej
						2:
							pose.texture = snake2j
						3:
							pose.texture = snake3j
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
	
	
	move_and_slide()


func _on_close_time_limit_timeout() -> void:
	emit_signal("rockIsClose")



func _on_area_2d_area_entered(area: Area2D) -> void:
	#print("start")
	close_time_limit.start()


func _on_area_2d_area_exited(area: Area2D) -> void:
	#print("stop")
	close_time_limit.stop()


func _on_jump_timeout() -> void:
	set_collision_layer_value(10, true)
	var spscene = splash.instantiate()
	spscene.position.y += 50
	add_child(spscene)
	can_jump = true
	audio_stream_player_2d.play()
	match Manager.current_pet:
		"deergon":
			match Manager.evo:
				1:
					pose.texture = deer1
				2:
					pose.texture = deer2
				3:
					pose.texture = deer3
		"penggon":
			match Manager.evo:
				1:
					pose.texture = pen1
				2:
					pose.texture = pen2
				3:
					pose.texture = pen3
		"snakegon":
			match Manager.evo:
				1:
					pose.texture = snake
				2:
					pose.texture = snake2
				3:
					pose.texture = snake3
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
