extends CharacterBody2D

@onready var dash_timer: Timer = $DashTimer
@onready var dash_again_timer: Timer = $DashAgainTimer

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const GRAV_SCALE = .8
const DASH_SPEED = 1500

var dashing = false
var canDash = true
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
	if Input.is_action_just_pressed("Dash") and canDash:
		dashing = true
		canDash = false
		dash_timer.start()
		dash_again_timer.start()
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("Left", "Right")
	if direction:
		if dashing:
			velocity.x = direction * DASH_SPEED
		else:
			velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_dash_timer_timeout() -> void:
	dashing = false


func _on_dash_again_timer_timeout() -> void:
	canDash = true
