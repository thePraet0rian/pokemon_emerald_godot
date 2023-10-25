extends Area2D


@export var object: int = 0

var text: Array


func _ready() -> void:
	
	text.append_array(dialogue.object_dialogue_string[object])

