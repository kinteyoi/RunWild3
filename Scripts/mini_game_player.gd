extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const GRAV_SCALE = .8
signal Up
signal Down

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta * GRAV_SCALE
	if velocity.y < 0:
		emit_signal("Up")
	else:
		emit_signal("Down")
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and Manager.activeScene != "swim":
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
