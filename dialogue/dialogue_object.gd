extends Area2D


@export var object: int = 0
@export var sig: String = ""


var text: Array


func _ready() -> void:
	
	text.append_array(dialogue.object_dialogue_string[object])
