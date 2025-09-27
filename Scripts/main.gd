extends Node2D

@onready var days_left = preload("res://Entities/UI/days_left.tscn")
@onready var rungame = preload("res://Entities/Screens/fruit_collection.tscn")
@onready var swimgame = preload("res://Entities/Screens/swimming.tscn")
@onready var flygame = preload("res://Entities/Screens/sky.tscn")
@onready var main_area = preload("res://Entities/Screens/main_area.tscn")
@onready var final_scene = preload("res://Entities/Screens/escape.tscn")
@onready var hatch: Node2D = $Hatch

var current_scene

func _on_hatch_finished() -> void:
	var dlscene = days_left.instantiate()
	add_child(dlscene)
	current_scene = dlscene
	hatch.queue_free()
	dlscene.finished.connect(Callable(self, "main_area_go_to"))
	
func main_area_go_to():
	var mascene = main_area.instantiate()
	add_child(mascene)
	current_scene.queue_free()

func go_to_swim():
	pass
func go_to_run():
	pass
func go_to_fly():
	pass
