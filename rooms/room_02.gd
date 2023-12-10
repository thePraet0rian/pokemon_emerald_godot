extends Node2D


@onready var npc: Area2D = $tilemap/npc
@onready var transition: Area2D = $transition2
@onready var transition_2: Area2D = $transition

func cutscene() -> void:
	
	npc.queue_free()
	transition.queue_free()
	transition_2.queue_free()
