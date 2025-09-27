extends Node2D
@onready var escape = preload("res://Entities/Screens/escape.tscn")
@onready var transition: Node2D = $Transition

func _ready() -> void:
	transition.leavesopen()


func _on_button_pressed() -> void:
	var escape_tscn = escape.instantiate()
	add_child(escape_tscn)


func _on_button_2_pressed() -> void:
	pass # Replace with function body.
