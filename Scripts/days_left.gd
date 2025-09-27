extends Node2D
@onready var label: Label = $Marker2D/Label
@onready var animation_player: AnimationPlayer = $AnimationPlayer
signal finished
func _ready() -> void:
	label.text = str(Manager.days_left) + " Days Left"
	for node in get_tree().get_nodes_in_group("objects"):
		node.queue_free()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	emit_signal("finished")
