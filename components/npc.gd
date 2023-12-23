extends Area2D


enum states {moving = 0, not_moving = 1}


@export var txt: Texture
@export var direction: Vector2 = Vector2(0, 0)
@export var sprite_offset: Vector2 = Vector2(0, 0)
@export var npc: int = 0
@export var frames: int = 12
@export var state: states = states.not_moving
@export var current_frame: int = 0
@export var can_left: bool = true
@export var can_right: bool = true
@export var can_up: bool = true
@export var can_down: bool = true


@onready var sprite: Sprite2D = $sprite_2d


var text: Array


func _ready() -> void:
	
	sprite.hframes = frames
	text.append_array(dialogue.npc_dialogue_string[npc])
	
	sprite.texture = txt
	sprite.offset = sprite_offset
	
	
	if state == states.moving:
		timer.start()
	
	
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


func update_direction() -> void:
	
	sprite.frame = current_frame


func quit() -> void:
	
	self.queue_free()


enum directions {walk_left = 0, walk_right = 1, walk_up = 2, walk_down = 3, look_left = 4, look_right = 5, look_up = 6, look_down = 7, nothing = 8}


@onready var timer: Timer = $timer
@onready var ray_cast: RayCast2D = $ray_cast_2d
@onready var anim_player: AnimationPlayer = $animation_player


func _on_timer_timeout() -> void:
	
	randomize() 
	var random_int: int = randi_range(0, 8)
	
	
	match random_int:
		
		directions.walk_left:
			if can_left:
				walk(Vector2(-16, 0))
			else:
				return
		directions.walk_right:
			if can_right:
				walk(Vector2(16, 0))
			else:
				return
		directions.walk_up:
			if can_up:
				walk(Vector2(0, -16))
			else:
				return
		directions.walk_down:
			if can_down:
				walk(Vector2(0, 16))
			else: 
				return
			
		directions.look_left:
			sprite.frame = 2
			
		directions.look_right:
			sprite.frame = 3
			
		directions.look_up:
			sprite.frame = 1
			
		directions.look_down:
			sprite.frame = 0
			
		directions.nothing:
			return


func walk(direction_vec: Vector2) -> void:
	
	ray_cast.target_position = direction_vec
	ray_cast.force_raycast_update()
	
	if !ray_cast.is_colliding():
		
		if direction_vec == Vector2(16, 0):
			anim_player.play("move_right")
		elif direction_vec == Vector2(-16, 0):
			anim_player.play("move_left")
		elif direction_vec == Vector2(0, 16):
			anim_player.play("move_down")
		elif direction_vec == Vector2(0, -16):
			anim_player.play("move_up")
		
		get_tree().create_tween().tween_property(self, "position", position + direction_vec, 0.5)
