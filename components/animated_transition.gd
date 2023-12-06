extends Area2D


@onready var anim_player: AnimationPlayer = $animation_player
@onready var sprite: Sprite2D = $door_sprite

@export var transition_position: Vector2 = Vector2(40, 88)
@export var next_room: int = 0
@export var door_type: int = 0

const door_sprites: Array = [preload("res://room_assets/animated_tiles/door_01.png"), preload("res://room_assets/animated_tiles/door_02.png"), preload("res://room_assets/animated_tiles/door_03.png"), preload("res://room_assets/animated_tiles/door_04.png")]
const top_sprites: Array = [preload("res://room_assets/animated_tiles/door_01_top.png"), preload("res://room_assets/animated_tiles/door_02_top.png"), preload("res://room_assets/animated_tiles/door_03_top.png"), preload("res://room_assets/animated_tiles/door_04_top.png")]


func _ready() -> void:
	
	$door_sprite.texture = door_sprites[door_type]
	
	if top_sprites[door_type] != null:
		$top_sprite.texture = top_sprites[door_type]
	else:
		$top_sprite.visible = false


func player_animation() -> void:
	
	anim_player.play("open_door")
	
	await anim_player.animation_finished
	global.animation_finished.emit()


func play_animation() -> void:
	
	anim_player.play("open_door")
