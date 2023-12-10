extends CharacterBody2D
class_name player

@onready var ray_cast: RayCast2D = $ray_cast
@onready var anim_tree: AnimationTree = $anim_tree
@onready var anim_tree_prop = $anim_tree.get("parameters/playback")
@onready var hitbox = $on_touched/hitbox
@onready var sprite: Sprite2D = $sprite

const TILE_SIZE: int = 16

var walk_speed : float = 6.0

var inital_position: Vector2 = Vector2.ZERO
var input_direction: Vector2 = Vector2.ZERO
var is_moving: bool = false
var percent: float = 0.0

var can_transition: bool = true
var transitioning: bool = false
var new_room: int
var touched: bool = false
var matching: Vector2 = Vector2.ZERO
var test: bool = false
var saving_position: Vector2 = Vector2.ZERO
var last_position: Vector2 = Vector2.ZERO
var save_pos: int 


var can_talk: bool = false
var text: Array

var has_pokemon: bool = false
var pokemon_can_move: bool = true
var pokemon_pos: Vector2 = Vector2.ZERO
var initial_pokemon_pos: Vector2 = Vector2.ZERO
var poke_percent: float = 0.0
var previous_positon: Vector2 = Vector2.ZERO

var opponent_pokemon: Array

var running: bool = false
var can_move: bool = true


func _ready() -> void:
	
	inital_position = position
	previous_positon = inital_position


func _input(event: InputEvent) -> void:
	
	if event.is_action_pressed("debug"):
		get_tree().debug_collisions_hint = not get_tree().debug_collisions_hint
		$collsion_polygon.visible = get_tree().debug_collisions_hint
		$on_entered/hitbox.visible = get_tree().debug_collisions_hint
		$on_touched/hitbox.visible = get_tree().debug_collisions_hint


func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("inventory"):
		open_inventory()
	
	animation()
	start_dialouge()
	
	if can_move:
		
		if !is_moving && !jumping: player_input()
		elif input_direction != Vector2.ZERO && is_moving && !jumping: move(delta)
		else: is_moving = false
		
		if percent == 0.0 and transitioning:
			
			transition()
		elif percent == 0.0 and can_animated_transition:
			
			if Input.is_action_just_pressed("move_up"):
				
				animated_transition()
		
		if jumping:
			jump(delta)


func player_input() -> void:
	
	if input_direction.y == 0: input_direction.x = Input.get_axis("move_left", "move_right")
	if input_direction.x == 0: input_direction.y = Input.get_axis("move_up", "move_down")
	
	if input_direction == Vector2(-1, 0):
		hitbox.rotation = 1.5708
	elif input_direction == Vector2(0, -1):
		hitbox.rotation = 3.14159
	elif input_direction == Vector2(1, 0):
		hitbox.rotation = -1.5708
	elif input_direction == Vector2(0, 1):
		hitbox.rotation = 0
	
	if touched:
		
		if Input.is_action_pressed("move_left") && matching.x == -1:
			transition()
		elif Input.is_action_pressed("move_left") && matching.x != -1: 
			touched = false
		
		if Input.is_action_pressed("move_right") && matching.x == 1:
			transition()
		elif Input.is_action_pressed("move_right") && matching.x != 1:
			touched = false
		
		if Input.is_action_pressed("move_up") && matching.y == -1:
			transition()
		elif Input.is_action_pressed("move_up") && matching.y != -1:
			touched = false
		
		if Input.is_action_pressed("move_down") && matching.y == 1:
			transition()
		elif Input.is_action_pressed("move_down") && matching.y != 1:
			touched = false
	
	if jumpable:
		
		if Input.is_action_just_pressed("move_left") && ledge_direction != Vector2(-1, 0):
			jumpable = false
		elif Input.is_action_just_pressed("move_right") && ledge_direction != Vector2(1, 0):
			("right")
			jumpable = false
		elif Input.is_action_just_pressed("move_up") && ledge_direction != Vector2(0, -1):
			jumpable = false
		elif Input.is_action_just_pressed("move_down") && ledge_direction != Vector2(0, 1):
			jumpable = false
	
	
	if Input.is_action_pressed("shift"):
		running = true
		walk_speed = 10.0
	else:
		running = false
		walk_speed = 6.0
	
	var step: Vector2 = input_direction * TILE_SIZE
	ray_cast.target_position = step
	ray_cast.force_raycast_update()
	
	if !jumpable:
		if !ray_cast.is_colliding():
			if input_direction != Vector2.ZERO:
				
				inital_position = position
				is_moving = true
		
	else:
		
		if input_direction == ledge.direction and jumpable: 
			
			inital_position = position
			percent = 0.0  
			jumping = true
		elif input_direction != ledge.direction && input_direction != Vector2.ZERO:
			
			inital_position = position
			jumpable = false
			jumping = false


var jumping: bool = false


func move(delta: float) -> void:
	
	percent += walk_speed * delta
	
	if percent >= 1.0:
		position = inital_position + (TILE_SIZE * input_direction)
		percent = 0.0
		is_moving = false
		
	else:
		position = inital_position + (TILE_SIZE * input_direction * percent)
		can_transition = true

var jump_test: float = -2

func jump(delta: float) -> void:
	
	percent += jump_test * delta
	
	if percent >= 2.0:
		
		position = inital_position + (TILE_SIZE * input_direction) * 2 
		percent = 0.0
		jumping = false
		jumpable = false
		input_direction = Vector2.ZERO
		jump_test = -2.0
		
	else:
		position = inital_position + (TILE_SIZE * input_direction * percent)
		jump_test += .3
 


func animation() -> void:
	
	
	if input_direction != Vector2.ZERO:
		
		
		anim_tree.set("parameters/walk/blend_position", input_direction)
		anim_tree.set("parameters/idle/blend_position", input_direction)
		anim_tree.set("parameters/run/blend_position", input_direction)
		
		if !running:
			anim_tree_prop.travel("walk")
		else:
			anim_tree_prop.travel("run")
	else:
		anim_tree_prop.travel("idle")


func transition() -> void:
	
	process_mode = Node.PROCESS_MODE_DISABLED
	global.emit_signal("transition", new_room, next_position, 0)
	
	can_transition = true
	transitioning = false
	touched = false


func animated_transition() -> void:
	
	anim_tree.process_mode = Node.PROCESS_MODE_DISABLED
	can_move = false
	
	entered.player_animation()
	
	await get_tree().create_timer(0.3).timeout
	
	anim_tree.process_mode = Node.PROCESS_MODE_INHERIT
	
	await get_tree().create_tween().tween_property(self, "position", position + Vector2(0,-16), 0.25).finished
	global.transition.emit(new_room, animated_transition_position, 1)
	anim_tree.process_mode = Node.PROCESS_MODE_DISABLED
	can_animated_transition = false


@onready var sfx_player: AudioStreamPlayer = $sfx_player


func start_dialouge() -> void:
	
	if can_talk:
		if Input.is_action_just_pressed("space"):
			
			sfx_player.play()
			await sfx_player.finished
			
			global.object.emit(dialogue_sig)
			
			process_mode = Node.PROCESS_MODE_DISABLED
			global.emit_signal("start_dialogue", text)
			can_talk = false


var next_position: Vector2 = Vector2.ZERO


func _on_on_entered_area_entered(area: Area2D) -> void:
	
	if "transition" in area.name:
		
		if area.type == 0:
			if can_transition:
				
				new_room = area.new_room
				next_position = area.next_position
				
				transitioning = true


var can_animated_transition: bool = false
var entered: Area2D
var animated_transition_position: Vector2 = Vector2.ZERO

var dialogue_sig: String = ""


func _on_on_touched_area_entered(area: Area2D) -> void:
	
	if "transition" in area.name:
		
		if area.type == 1:
			
			print("yes 1ww")
			
			new_room = area.new_room
			save_pos = area.saves
			next_position = area.next_position
			
			matching = area.direction
			touched = true
	
	elif "npc" in area.name: 
		
		can_talk = true
		text.clear()
		text.append_array(area.text)
		
		area.direction = input_direction
		area.update()
	
	elif "dialouge_object" in area.name:
		
		can_talk = true
		text.clear()
		text.append_array(area.text)
		
		if area.sig != "":
			dialogue_sig = area.sig
	
	elif "ledge" in area.name:
		
		if input_direction == area.direction:
			ledge = area
			jumpable = true
			ledge_direction = ledge.direction
	
	elif "animated_trans" in area.name:
		
		entered = area
		new_room = area.next_room
		animated_transition_position = area.transition_position
		can_animated_transition = true


var jumpable: bool = false
var ledge: Area2D
var ledge_direction: Vector2


func _on_on_touched_area_exited(area: Area2D) -> void:
	
	if "npc" in area.name:
		
		can_talk = false
	elif "object" in area.name:
		
		can_talk = false
	elif "animated_trans" in area.name:
		
		can_animated_transition = false


const inventory_scn: PackedScene = preload("res://player_assets/inventory/inventory.tscn")

func open_inventory() -> void:
	
	var inventroy_inst: CanvasLayer = inventory_scn.instantiate()
	get_parent().add_child(inventroy_inst)
	process_mode = Node.PROCESS_MODE_DISABLED
