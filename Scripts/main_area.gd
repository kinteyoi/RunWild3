extends Node2D

@onready var transition: Node2D = $Transition

func _ready() -> void:
	transition.leavesopen()
