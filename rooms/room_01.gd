extends Node2D


@onready var transition: Area2D = $transition


func cutscene() -> void:
	
	transition.new_room = -4
