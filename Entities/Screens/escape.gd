extends Node2D
@onready var winning: Panel = $RunnerPet/Camera2D/GG/Winning
signal retire
@onready var transition: Node2D = $Transition

func _ready() -> void:
	transition.leavesopen()
func _on_try_again_pressed() -> void:
	Manager.Reset()
	get_tree().change_scene_to_file("res://Entities/main.tscn")


func _on_win_body_entered(body: Node2D) -> void:
	get_tree().paused = true
	winning.visible = true


func _on_go_again_pressed() -> void:
	Manager.Reset()
	get_tree().change_scene_to_file("res://Entities/main.tscn")


func _on_give_up_pressed() -> void:
	if not is_connected("retire", Callable(get_parent(), "go_to_ENDGAME")):
			connect("retire", Callable(get_parent(), "go_to_ENDGAME"))
			emit_signal("retire")


func _on_retire_pressed() -> void:
	if not is_connected("retire", Callable(get_parent(), "go_to_ENDGAME")):
			connect("retire", Callable(get_parent(), "go_to_ENDGAME"))
			emit_signal("retire")
