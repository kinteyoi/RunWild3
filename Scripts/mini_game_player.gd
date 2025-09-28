extends CharacterBody2D

@onready var dash_timer: Timer = $DashTimer
@onready var dash_again_timer: Timer = $DashAgainTimer
@onready var pose: Sprite2D = $Pose
@onready var pose_jump: Sprite2D = $PoseJump
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var babbydog = preload("res://Assets/Players/DeerDog/Kritter1_adultback6.png")
@onready var meddog = preload("res://Assets/Players/DeerDog/Kritter1_adultback3.png")
@onready var bigdog = preload("res://Assets/Players/DeerDog/Kritter1_adultback.png")

@onready var babbydogjump = preload("res://Assets/Players/DeerDog/babyjumpsheet.png")
@onready var meddogjump = preload("res://Assets/Players/DeerDog/teenjumpsheet.png")
@onready var bigdogjump = preload("res://Assets/Players/DeerDog/adultjumpsheet.png")

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const GRAV_SCALE = .8
const DASH_SPEED = 1500

var dashing = false
var canDash = true
signal Up
signal Down

func player():
	pass

func _ready() -> void:
	match Manager.current_pet:
		"deergon":
			match Manager.evo:
				1:
					pose.texture = babbydog
				2:
					pose.texture = meddog
				3:
					pose.texture = bigdog
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
		match Manager.current_pet:
			"deergon":
				match Manager.evo:
					1:
						pose_jump.texture = babbydogjump
					2:
						pose_jump.texture = meddogjump
					3:
						pose_jump.texture = bigdogjump
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
		pose.visible = true
		pose_jump.visible = false
		animation_player.play("jump")
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


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "jump":
		print("hump")
		animation_player.play("walk")
		pose.visible = true
		match Manager.current_pet:
			"deergon":
				match Manager.evo:
					1:
						pose.texture = babbydog
					2:
						pose.texture = meddog
					3:
						pose.texture = bigdog
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
