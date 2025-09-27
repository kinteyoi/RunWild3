extends Area2D

@onready var obby = preload("res://Assets/Environment/runwild_swimlog1.png")
@onready var obby2 = preload("res://Assets/Environment/runwild_swimlog2.png")
@onready var obby3 = preload("res://Assets/Environment/runwild_swimbranch1.png")
@onready var obby4 = preload("res://Assets/Environment/runwild_swimbranch2.png")
@onready var sprite_2d: Sprite2D = $Sprite2D
@export var animation_player: AnimationPlayer

func _ready() -> void:
	var obby_graphics = [obby, obby2, obby3, obby4]
	var random_item = obby_graphics.pick_random()
	sprite_2d.texture = random_item
	animation_player.play("sway")

@export var speed = 70
var direction: Vector2 = Vector2.DOWN * 200
# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += direction * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_body_entered(body) -> void:
	body.queue_free()
