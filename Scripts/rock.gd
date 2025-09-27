extends CharacterBody2D

@export var speed = 100
var direction: Vector2 = Vector2.DOWN
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocity = direction.normalized() * speed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	move_and_collide(velocity * delta)


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
