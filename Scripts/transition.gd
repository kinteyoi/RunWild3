extends Node2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
signal exited
var exit = false

func leavesopen():
	animation_player.play_backwards("LeavesOpen")
	get_tree().paused = false
func leavesclose():
	exit = true
	animation_player.play("LeavesOpen")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "LeavesOpen":
		if exit == true:
			self.emit_signal("exited")
