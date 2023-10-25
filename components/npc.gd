extends Area2D


@export var txt: Texture
@export var direction: Vector2 = Vector2(0, 0)
@export var offset: Vector2 = Vector2(0, 0)
@export var npc: int = 0

@onready var sprite: Sprite2D = $sprite_2d

var text: Array


func _ready() -> void:
	
	text.append_array(dialogue.npc_dialogue_string[npc])
	
	sprite.texture = txt
	sprite.offset = offset
	
	if direction.x == 1:
		sprite.frame = 3
	elif direction.x == -1:
		sprite.frame = 2
	
	if direction.y == 1:
		sprite.frame = 0
	elif direction.y == -1:
		sprite.frame = 1


func update() -> void:
	
	pass
