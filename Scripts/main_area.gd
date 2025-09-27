extends Node2D

@onready var transition: Node2D = $Transition

func _ready() -> void:
	transition.leavesopen()


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Entities/Screens/escape.tscn")
