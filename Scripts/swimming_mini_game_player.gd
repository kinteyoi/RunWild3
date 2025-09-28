extends CharacterBody2D
@onready var icon: Sprite2D = $Icon

#DEERGON

@onready var deer1 = preload("res://Assets/Players/DeerDog/runwild_babyswim.png")
@onready var deer2 = preload("res://Assets/Players/DeerDog/runwild_teenswim.png")
@onready var deer3 = preload("res://Assets/Players/DeerDog/runwild_adultswim.png")
@onready var close_time_limit: Timer = $CloseTimeLimit
@onready var pose: Sprite2D = $Icon

@onready var speed = 150

signal rockIsClose 
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
					pass
				2:
					pass
				3:
					pass
		"snakegon":
			match Manager.evo:
				1:
					pass
				2:
					pass
				3:
					pass
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
	move_and_slide()


func _on_close_time_limit_timeout() -> void:
	emit_signal("rockIsClose")



func _on_area_2d_area_entered(area: Area2D) -> void:
	#print("start")
	close_time_limit.start()


func _on_area_2d_area_exited(area: Area2D) -> void:
	#print("stop")
	close_time_limit.stop()
