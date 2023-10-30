extends Area2D


@export var txt: Texture
@export var direction: Vector2 = Vector2(0, 0)
@export var offset: Vector2 = Vector2(0, 0)
@export var npc: int = 0
@export var frames: int = 0

@onready var sprite: Sprite2D = $sprite_2d

var text: Array


func _ready() -> void:
	
	sprite.hframes = frames
	text.append_array(dialogue.npc_dialogue_string[npc])
	
	sprite.texture = txt
	sprite.offset = offset
	
	
	match frames:
		
		12:
			if direction.x == 1:
				sprite.frame = 3
			elif direction.x == -1:
				sprite.frame = 2
			
			if direction.y == 1:
				sprite.frame = 0
			elif direction.y == -1:
				sprite.frame = 1
		
		9:
			pass


func update() -> void:
	
	match frames:
		
		12:
			if direction.x == -1:
				sprite.frame = 3
			elif direction.x == 1:
				sprite.frame = 2
			
			if direction.y == -1:
				sprite.frame = 0
			elif direction.y == 1:
				sprite.frame = 1
