extends Area2D


enum directions {LEFT = 0, RIGHT = 1, UP = 2, DOWN = 3, NONE = 4}

@export var export_direction: directions = directions.DOWN

var direction: Vector2

const directions_const: Array = [Vector2(-1, 0), Vector2(1, 0), Vector2(0, -1), Vector2(0, 1), Vector2.ZERO]

func _ready() -> void:
	
	direction = directions_const[export_direction]

