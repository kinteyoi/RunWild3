extends Node2D
@onready var escape = preload("res://Entities/Screens/escape.tscn")
@onready var transition: Node2D = $Transition
signal run
signal swim
signal fly
var goto : String
func _ready() -> void:
	transition.leavesopen()


func _on_button_pressed() -> void:
	var escape_tscn = escape.instantiate()
	add_child(escape_tscn)

func _on_run_pressed() -> void:
	transition.leavesclose()
	goto = "run"
	

func _on_swim_pressed() -> void:
	transition.leavesclose()
	goto = "swim"
	
	
func _on_fly_pressed() -> void:
	transition.leavesclose()
	goto = "fly"


func _on_transition_exited() -> void:
	print("exitedHERE")
	if goto == "run":
		connect("run", Callable(get_parent(), "go_to_run"))
		emit_signal("run")
	elif goto == "swim":
		connect("swim", Callable(get_parent(), "go_to_swim"))
		emit_signal("swim")
	elif goto == "fly":
		connect("fly", Callable(get_parent(), "go_to_fly"))
		emit_signal("fly")
