extends CharacterBody2D
@onready var icon: Sprite2D = $Icon

#DEERGON

@onready var deer1 = preload("res://Assets/Players/DeerDog/Kritter1_adultback7.png")
@onready var deer2 = preload("res://Assets/Players/DeerDog/Kritter1_adultback4.png")
@onready var deer3 = preload("res://Assets/Players/DeerDog/Kritter1_adultback1.png")

@onready var speed = 150
func _ready() -> void:
	match Manager.current_pet:
		"deergon":
			if Manager.evo == 0:
				icon.texture = deer1
			elif Manager.evo == 1:
				icon.texture = deer2
			else:
				icon.texture = deer3
func _physics_process(delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * speed

	move_and_slide()
