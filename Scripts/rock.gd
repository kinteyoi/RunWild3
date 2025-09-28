extends Area2D

@onready var obby = preload("res://Assets/Environment/runwild_swimlog1.png")
@onready var obby2 = preload("res://Assets/Environment/runwild_swimlog2.png")
@onready var obby3 = preload("res://Assets/Environment/runwild_swimbranch1.png")
@onready var obby4 = preload("res://Assets/Environment/runwild_swimbranch2.png")

@onready var obby5 = preload("res://Assets/Environment/runwild_swimrock1.png")
@onready var obby6 = preload("res://Assets/Environment/runwild_swimrock2.png")

@onready var sprite_2d: Sprite2D = $Sprite2D
@export var animation_player: AnimationPlayer
@onready var rocks: AnimationPlayer = $Rocks
@export var speed = 200
var direction: Vector2 = Vector2.DOWN * speed
func _ready() -> void:
	var obby_graphics = [obby, obby2, obby3, obby4, obby5, obby6]
	var random_item = obby_graphics.pick_random()
	sprite_2d.texture = random_item
	if random_item == obby5 or random_item == obby6:
		rocks.play("rocks")
		speed = 120
		direction = Vector2.DOWN * speed
	elif random_item == obby3 or random_item == obby4:
		rocks.play("woodsmall")
	else:
		rocks.play("wood")
	animation_player.play("sway")

# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += direction * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_body_entered(body) -> void:
	body.queue_free()
