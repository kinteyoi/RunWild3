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
	print(current_scene)
	var mascene = main_area.instantiate()
	add_child(mascene)
	current_scene.queue_free()
	current_scene = mascene

func go_to_swim():
	print(current_scene)
	var sgscene = swimgame.instantiate()
	add_child(sgscene)
	current_scene.queue_free()
	current_scene = sgscene
func go_to_run():
	print(current_scene)
	print("bust")
	var rgscene = rungame.instantiate()
	add_child(rgscene)
	current_scene.queue_free()
	current_scene = rgscene
func go_to_fly():
	print(current_scene)
	var fgscene = flygame.instantiate()
	add_child(fgscene)
	current_scene.queue_free()
	current_scene = fgscene
func go_to_days():
	print(current_scene)
	Manager.days_left -= 1
	var dltdscene = days_left.instantiate()
	add_child(dltdscene)
	current_scene.queue_free()
	current_scene = dltdscene
