extends Area2D


enum types {entered = 0, touched = 1}
enum save_type {save_current = 0, save_last = 1}

@export var new_room: int = 0
@export var polygon: Array = [Vector2(-8, -8), Vector2(8, -8), Vector2(-8, 8), Vector2(8, 8)]
@export var type: types = types.entered
@export var saves: save_type = save_type.save_current
@export var next_position: Vector2 
@export var direction: Vector2 = Vector2(0, 1)

@onready var hitbox: CollisionPolygon2D = $hitbox


func _ready() -> void:
	
	hitbox.polygon = polygon
