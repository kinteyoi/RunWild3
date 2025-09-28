extends Node2D



func _on_try_again_pressed() -> void:
	Manager.Reset()
	print("ITs Pushed")
	get_tree().change_scene_to_file("res://Entities/main.tscn")
