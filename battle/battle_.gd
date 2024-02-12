extends CanvasLayer
class_name battle



######################################################################################################################



@onready var anim_player: AnimationPlayer = $anim_player
@onready var sfx_player: AudioStreamPlayer = $sfx_player


var player_pokemon: Array
var enemy_pokemon: Array

var player_inventory: Array = global.player_inventory
var enemy_inventory: Array

var player_current_pokemon: int
var enemy_current_pokemon: int

var battle_type: int



######################################################################################################################



@onready var player_sprite: Sprite2D = $ui/enemy_sprite
@onready var enemy_sprite: Sprite2D = $ui/player_sprite

@onready var player_name_label: Label = $info/player_info/name
@onready var enemy_name_label: Label = $info/enemy_info/name

@onready var player_level_label: Label = $info/player_info/level
@onready var enemy_level_label: Label = $info/enemy_info/level

@onready var menue_label: Label = $menue/Label


func set_battle(_enemy_pokemon_arr: Array, _res: Array, _battle_type: int) -> void:
	
	enemy_pokemon = _enemy_pokemon_arr
	battle_type = _battle_type
	
	set_bag()
	set_attacks()
	play_battle_intro(_battle_type) 


func set_battle_interface() -> void:
	
	player_sprite.texture = pokemon_data.pokemon_back_sprite[player_pokemon[0][0][0]]
	enemy_sprite.texture = pokemon_data.pokemon_front_sprite[enemy_pokemon[0][0][0]]
	
	player_name_label.text = player_pokemon[0][0][1]
	enemy_name_label.text = enemy_pokemon[0][0][1]
	
	player_level_label.text = "Lv" + str(player_pokemon[0][0][10])
	enemy_level_label.text = "Lv" + str(enemy_pokemon[0][0][10])
	
	menue_label.text = "What will " + str(player_pokemon[0][0][1]) + " do?"


const item_scn: PackedScene = preload("res://components/item.tscn")


func set_bag() -> void: #TODO: finish
	
	for i in range(5):
		for j in range(len(player_inventory[i])):
			
			var item_inst: Label = item_scn.instantiate()


@onready var attack_labels: Array = [[$attack_select/attack_01, $attack_select/attack_02], [$attack_select/attack_03, $attack_select/attack_04]]


func set_attacks() -> void:
	
	for i in range(len(player_pokemon[1])):
		for j in range(len(player_pokemon[1][i])):
			attack_labels[i][j].text = player_pokemon[1][i][j][0]


func play_battle_intro(_battle_type: int) -> void:
	
	anim_player.play("start")
	await anim_player.animation_finished



######################################################################################################################
###########################################################



@onready var attack_select: Node2D = $attack_select
@onready var pokemon_select: Node2D = $pokemon
@onready var item_select: Node2D = $bag


enum states {MENUE, ATTACK_SELECT, POKEMON_SELECT, ITEM_SELECT, DIALOGUE, NULL}


var current_state: states = states.MENUE


func _input(event: InputEvent) -> void:
	
	match current_state:
		
		states.MENUE:
			menue_input(event)
		states.ATTACK_SELECT:
			attack_select_input(event)
		states.POKEMON_SELECT:
			pass
		states.ITEM_SELECT:
			pass


###########################################################


@onready var menue_cursor: Sprite2D = $menue/menue_cursor


const menue_cursor_positions: Array = [[Vector2(147, 128), Vector2(203, 128)], [Vector2(147, 144), Vector2(203, 144)]]


var menue_cursor_index: Vector2i = Vector2i.ZERO


func menue_input(event: InputEvent) -> void:
	
	if event.is_action_pressed("move_left"):
		if menue_cursor_index.x != 0:
			menue_cursor_index.x -= 1
	elif event.is_action_pressed("move_right"):
		if menue_cursor_index.x != 1:
			menue_cursor_index.x += 1
	elif event.is_action_pressed("move_down"):
		if menue_cursor_index.y != 1:
			menue_cursor_index.y += 1
	elif event.is_action_pressed("move_up"):
		if menue_cursor_index.y != 0:
			menue_cursor_index.y -= 1
	
	menue_cursor.position = menue_cursor_positions[menue_cursor_index.y][menue_cursor_index.x]
	
	if event.is_action_pressed("space"):
		sfx_player.play()
		await sfx_player.finished
		
		match_menue_input()


func match_menue_input() -> void:
	
	if menue_cursor_index == Vector2i(0, 0):
		attack_select.visible = true
		current_state = states.ATTACK_SELECT
	elif menue_cursor_index == Vector2i(1, 0):
		item_select.visible = true
		current_state = states.ITEM_SELECT
	elif menue_cursor_index == Vector2i(0, 1):
		pokemon_select.visible = true
		current_state = states.POKEMON_SELECT
	elif menue_cursor_index == Vector2i(1, 1):
		global.end_battle.emit()


@onready var attack_select_cursor: Sprite2D = $attack_select/attack_select_cursor
@onready var attack_pp_label: Label = $attack_select/info/pp
@onready var attack_type_label: Label = $attack_select/info/type


var attack_select_index: Vector2i = Vector2i.ZERO
var attack_pressed: bool = false


const attack_select_cursor_positions: Array = [[Vector2(11, 128), Vector2(11, 145)], [Vector2(83, 128), Vector2(83, 146)]]


func attack_select_input(event: InputEvent) -> void:
	
	if event.is_action_pressed("move_left"):
		if attack_select_index.x != 0:
			attack_select_index.x -= 1
	elif event.is_action_pressed("move_right"):
		if attack_select_index.x != 1:
			attack_select_index.x += 1
	elif event.is_action_pressed("move_down"):
		if attack_select_index.y != 1:
			attack_select_index.y += 1
	elif event.is_action_pressed("move_up"):
		if attack_select_index.y != 0:
			attack_select_index.y -= 1
	
	update_attack_select_ui()
	
	if event.is_action_pressed("shift"):
		attack_select.visible = false
		current_state = states.MENUE
	elif event.is_action_pressed("space"):
		attack_pressed = true
		
		sfx_player.play()
		await sfx_player.finished
		
		current_state = states.NULL
		action([0, player_pokemon[player_current_pokemon][1][attack_select_index.x][attack_select_index.y]])


func update_attack_select_ui() -> void: #TODO: Finish
	
	attack_pp_label.text = ("PP    " + str(player_pokemon[player_current_pokemon][1][attack_select_index.y][attack_select_index.x]))
	attack_type_label.text = ("TYPE/" + str(attacks.attacks[player_pokemon[player_current_pokemon][1][attack_select_index.y][attack_select_index.x]]))


func pokemon_select_input(event: InputEvent) -> void:
	
	pass


func bag_select_input(event: InputEvent) -> void:
	
	pass



###########################################################
######################################################################################################################



func action(_player_actions: Array) -> void:
	
	var player_actions: Array = _player_actions
	var enemy_actions: Array = generate_enemy_actions()
	
	if player_actions[0] < enemy_actions[0]:
		pass
	elif player_actions[0] > enemy_actions[0]:
		pass
	elif player_actions[0] == 0 and enemy_actions[0] == 0:
		pass
	else:
		pass


func generate_enemy_actions() -> Array:
	
	if battle_type == 0:
		pass
	elif battle_type == 1:
		pass
	
	return [0, "Tackle"]


const player_first: int = 0
const enemy_first: int = 0


func execute_actions(action_order: int, player_actions, enemy_actions) -> void:
	
	if action_order == player_first:
		pass
	else:
		pass


func execute_attack() -> void:
	pass


func execute_item() -> void:
	pass


func execute_change() -> void:
	pass


func execute_flee() -> void:
	pass



######################################################################################################################



