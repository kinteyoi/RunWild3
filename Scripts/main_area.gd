extends Node2D
@onready var escape = preload("res://Entities/Screens/escape.tscn")
@onready var food = preload("res://Entities/Objects/candy_apple.tscn")
@onready var transition: Node2D = $Transition
@onready var food_spawn: PathFollow2D = $Path2D/FoodSpawn
@onready var fly_stats_3: Label = $Points/RunwildButtonblank/FlyStats3
@onready var texture_progress_bar: TextureProgressBar = $Points/TextureProgressBar

@onready var fly_stats: Label = $Points/Rest/FlyStats
@onready var run_stats: Label = $Points/Run/RunStats
@onready var swim_stats: Label = $Points/Swim/SwimStats

@onready var flybutt: Button = $Points/Rest/Fly
@onready var runbutt: Button = $Points/Run/Run
@onready var swimbutt: Button = $Points/Swim/Swim
@onready var rustbutt: Button = $Points/Fly/Rust

signal run
signal swim
signal fly
signal sleep
var goto : String
func _ready() -> void:
	flybutt.disabled = false
	runbutt.disabled = false
	swimbutt.disabled = false
	rustbutt.disabled = false
	transition.leavesopen()

func _on_run_pressed() -> void:
	disable_all()
	energy_drain("run")
	transition.leavesclose()
	goto = "run"
	

func _on_swim_pressed() -> void:
	disable_all()
	energy_drain("swim")
	transition.leavesclose()
	goto = "swim"
	
	
func _on_fly_pressed() -> void:
	disable_all()
	energy_drain("swim")
	transition.leavesclose()
	goto = "fly"


func _on_transition_exited() -> void:
	print("exitedHERE")
	if goto == "run":
		if not is_connected("run", Callable(get_parent(), "go_to_run")):
			connect("run", Callable(get_parent(), "go_to_run"))
			emit_signal("run")
	elif goto == "swim":
		if not is_connected("swim", Callable(get_parent(), "go_to_swim")):
			connect("swim", Callable(get_parent(), "go_to_swim"))
			emit_signal("swim")
	elif goto == "fly":
		if not is_connected("fly", Callable(get_parent(), "go_to_fly")):
			connect("fly", Callable(get_parent(), "go_to_fly"))
			emit_signal("fly")
	elif goto == "sleep":
		if not is_connected("sleep", Callable(get_parent(), "go_to_days")):
			connect("sleep", Callable(get_parent(), "go_to_days"))
			emit_signal("sleep")


func _on_rust_pressed() -> void:
	disable_all()
	Manager.energy = 100
	transition.leavesclose()
	goto = "sleep"

func _process(delta: float) -> void:
	texture_progress_bar.value = Manager.energy
	fly_stats_3.text = str(Manager.currency)
	fly_stats.text = str(int(Manager.flyStats))
	run_stats.text = str(int(Manager.runStats))
	swim_stats.text = str(int(Manager.swimStats))

func _on_eat_pressed() -> void:
	if Manager.currency >= 10:
		Manager.currency -= 10
		var rand = randf_range(0, 1)
		food_spawn.progress_ratio = rand
		var capple = food.instantiate()
		capple.global_position = food_spawn.global_position
		get_tree().get_root().add_child(capple)
	else:
		pass
		
func energy_drain(minigame):
	match Manager.current_pet:
		"deergon":
			if minigame == "run":
				Manager.energy -= Manager.affinity_drain
			else:
				Manager.energy -= Manager.base_drain
		"penggon":
			if minigame == "fly":
				Manager.energy -= Manager.affinity_drain
			else:
				Manager.energy -= Manager.base_drain
		"snakegon":
			if minigame == "swim":
				Manager.energy -= Manager.affinity_drain
			else:
				Manager.energy -= Manager.base_drain
		"poopgon":
			Manager.energy -= Manager.base_drain
		"mongeygon":
			if minigame == "run":
				Manager.energy -= Manager.affinity_drain
			else:
				Manager.energy -= Manager.base_drain

func disable_all():
		flybutt.disabled = true
		runbutt.disabled = true
		swimbutt.disabled = true
		rustbutt.disabled = true
