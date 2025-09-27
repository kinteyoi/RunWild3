extends Node2D
@onready var label: Label = $Marker2D/Label
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var main = preload("res://Entities/Screens/main_area.tscn")
func _ready() -> void:
	label.text = str(Manager.days_left) + " Days Left"
	for node in get_tree().get_nodes_in_group("objects"):
		node.queue_free()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_packed(main)
