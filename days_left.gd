extends Node2D
@onready var label: Label = $Marker2D/Label
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var label_2: Label = $Marker2D/Label2

signal finished
func _ready() -> void:
	label.text = str(Manager.days_left) + " Days Left"
	for node in get_tree().get_nodes_in_group("objects"):
		node.queue_free()
	if Manager.days_left == 8:
		Manager.evo = 2 
		label_2.visible = true
	elif Manager.days_left == 4:
		Manager.evo = 3
		label_2.visible = true
	



func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if not is_connected("finished", Callable(get_parent(), "main_area_go_to")):
		connect("finished", Callable(get_parent(), "main_area_go_to"))
	emit_signal("finished")
