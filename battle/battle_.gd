extends CanvasLayer
class_name battle



######################################################################################################################



@onready var anim_player: AnimationPlayer = $anim_player
@onready var sfx_player: AudioStreamPlayer = $sfx_player


var player_pokemon: Array = global.player_pokemon
var enemy_pokemon: Array

var player_inventory: Array = global.player_inventory
var enemy_inventory: Array

var player_current_pokemon: int
var enemy_current_pokemon: int

var battle_type: int



######################################################################################################################



@onready var player_sprite: Sprite2D = $ui/player_sprite
@onready var enemy_sprite: Sprite2D = $ui/enemy_sprite

@onready var player_name_label: Label = $info/player_info/name
@onready var enemy_name_label: Label = $info/enemy_info/name

@onready var player_level_label: Label = $info/player_info/level
@onready var enemy_level_label: Label = $info/enemy_info/level

@onready var menue_label: Label = $menue/Label


func set_battle(_enemy_pokemon_arr: Array, _battle_type: int) -> void:
	
	print(_enemy_pokemon_arr)
	enemy_pokemon = _enemy_pokemon_arr
	battle_type = _battle_type
	
	set_bag()
	set_attacks()
	set_battle_interface()
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
	
	print(player_inventory)
	
	for i in range(5):
		for j in range(len(player_inventory[i])):
			
			var item_inst: Label = item_scn.instantiate()
			types[i].add_child(item_inst)
			item_inst.text = player_inventory[i][j][0]
			item_inst.position = Vector2(120, 24 + 16 * j)


@onready var attack_labels: Array = [[$attack_select/attack_01, $attack_select/attack_02], [$attack_select/attack_03, $attack_select/attack_04]]


func set_attacks() -> void:
	
	for i in range(len(player_pokemon[0][1])):
		for j in range(len(player_pokemon[0][1][i])):
			attack_labels[i][j].text = player_pokemon[0][1][i][j][0]


func play_battle_intro(_battle_type: int) -> void:
	
	if _battle_type == 0:
		pass
	elif _battle_type == 1:
		
		anim_player.play("start_trainer_battle")
		await anim_player.animation_finished
		
		start_dialogue(["Lady somehting would like to battle"])
		await dialogue_finished
		
		anim_player.play("start_trainer_battle_02")



######################################################################################################################
###########################################################



@onready var menue_select: Node2D = $menue
@onready var attack_select: Node2D = $attack_select
@onready var pokemon_select: Node2D = $pokemon
@onready var item_select: Node2D = $bag


enum states {MENUE, ATTACK_SELECT, POKEMON_SELECT, ITEM_SELECT, DIALOGUE, NULL}


var current_state: states = states.NULL


func _input(event: InputEvent) -> void:
	
	match current_state:
		
		states.MENUE:
			menue_input(event)
		states.ATTACK_SELECT:
			attack_select_input(event)
		states.POKEMON_SELECT:
			pokemon_select_input(event)
		states.ITEM_SELECT:
			item_select_input(event)
		states.DIALOGUE:
			dialogue_input(event)


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
		action([3, "Flee"])


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
	
	attack_select_cursor.position = attack_select_cursor_positions[attack_select_index.x][attack_select_index.y]
	
	attack_pp_label.text = ("PP    " + str(player_pokemon[player_current_pokemon][1][attack_select_index.y][attack_select_index.x][1]))
	attack_type_label.text = ("TYPE/" + str(attacks.attacks[player_pokemon[player_current_pokemon][1][attack_select_index.y][attack_select_index.x][0]][0]))


func pokemon_select_input(event: InputEvent) -> void:
	
	if event.is_action_pressed("shift"):
		
		menue_select.visible = true
		pokemon_select.visible = false
		current_state = states.MENUE


@onready var types: Array[Node2D] = [$bag/items, $bag/pokeballs, $bag/tm, $bag/berries, $bag/key_items]

@onready var item_select_point: Sprite2D = $bag/point
@onready var item_select_bag: Sprite2D = $bag/bag
@onready var item_select_cursor: Sprite2D = $bag/bag_cursor
@onready var item_select_info: Sprite2D = $bag/info


const item_select_info_textures: Array[Resource] = [preload("res://battle_assets/bag_assets/item_sign.png"), preload("res://battle_assets/bag_assets/pokeball_sign.png"), preload("res://battle_assets/bag_assets/tmandhm_sign.png"), preload("res://battle_assets/bag_assets/berries_sign.png"), preload("res://battle_assets/bag_assets/key_items_sign.png")]
const item_select_bag_textures: Array[Resource] = [preload("res://battle_assets/bag_assets/bag_01.png"), preload("res://battle_assets/bag_assets/bag_02.png"), preload("res://battle_assets/bag_assets/bag_03.png"), preload("res://battle_assets/bag_assets/bag_04.png"), preload("res://battle_assets/bag_assets/bag_05.png")]
const item_select_point_positions: Array[Vector2] = [Vector2(44, 29), Vector2(52, 29), Vector2(60, 29), Vector2(68, 29), Vector2(76, 29)]


var item_select_index: Vector2i = Vector2i.ZERO


func item_select_input(event: InputEvent) -> void:
	
	if event.is_action_pressed("move_left"):
		
		if item_select_index.x != 0:
			item_select_index.x -= 1
		else:
			item_select_index.x = 4
	elif event.is_action_pressed("move_right"):
		
		if item_select_index.x != 4:
			item_select_index.x += 1
		else:
			item_select_index.x = 0
	
	item_select_update()
	
	if event.is_action_pressed("move_up"):
		item_select_index.y -= 1
	elif event.is_action_pressed("move_down"):
		item_select_index.y += 1
	
	item_select_cursor.position.y
	
	if event.is_action_pressed("shift"):
		
		menue_select.visible = true
		item_select.visible = false
		current_state = states.MENUE


func item_select_update() -> void:
	
	item_select_point.position = item_select_point_positions[item_select_index.x]
	
	item_select_bag.texture = item_select_bag_textures[item_select_index.x]
	item_select_info.texture = item_select_info_textures[item_select_index.x]
	
	for i in range(len(types)):
		
		if i == item_select_index.x:
			types[i].visible = true
		else:
			types[i].visible = false



###########################################################
######################################################################################################################



func action(_player_actions: Array) -> void:
	
	print("battle action")
	
	var player_actions: Array = _player_actions
	var enemy_actions: Array = generate_enemy_actions()
	
	if player_actions[0] < enemy_actions[0]:
		execute_actions(1, player_actions, enemy_actions)
	elif player_actions[0] > enemy_actions[0]:
		execute_actions(0, player_actions, enemy_actions)
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
const enemy_first: int = 1

var execute_methods_arr: Array = [execute_attack, execute_item, execute_change, execute_flee]

signal action_finished_sig


func execute_actions(action_order: int, player_actions: Array, enemy_actions: Array) -> void:
	
	if action_order == player_first:
		
		execute_methods_arr[player_actions[0]].call(player_actions[1], 1)
		await action_finished_sig
		
		execute_methods_arr[enemy_actions[0]].call(enemy_actions[1], 0)
	else:
		
		execute_methods_arr[enemy_actions[0]].call(player_actions[1], 0)
		await action_finished_sig
		
		execute_methods_arr[player_actions[0]].call(player_actions[1], 1)


func execute_attack(action: String, opponent: int) -> void:
	pass


func execute_item(action: String, opponent: int) -> void:
	pass


func execute_change(action: String, opponent: int) -> void:
	pass


func execute_flee(action: String, opponent: int) -> void:
	
	if battle_type == 0:
		pass
	elif battle_type == 1:
		
		start_dialogue(["You cant run..."])



######################################################################################################################



@onready var dialogue_nde: Node2D = $dialouge
@onready var dialogue_timer: Timer = $dialouge/timer
@onready var dialogue_label: Label = $dialouge/text_label


var dialogue_text: Array
var dialogue_pressed: bool = true
var dialogue_line: int = 1

signal dialogue_finished

func start_dialogue(input_arr: Array) -> void:
	
	current_state = states.NULL
	
	dialogue_nde.visible = true
	dialogue_text = input_arr.duplicate()
	dialogue_timer.start()
	dialogue_line = 1
	
	for i in range(1):
		for j in range(len(input_arr[i])):
			
			await dialogue_timer.timeout
			dialogue_label.text += input_arr[i][j]
	
	current_state = states.DIALOGUE
	dialogue_pressed = false


func dialogue_input(event: InputEvent) -> void:
	
	if !dialogue_pressed:
		if event.is_action_pressed("space"):
			
			dialogue_pressed = true
			
			sfx_player.play()
			await sfx_player.finished
			
			if dialogue_line < len(dialogue_text):
				
				dialogue_label.text = ""
				
				for i in range(len(dialogue_text[dialogue_line])):
					await dialogue_timer.timeout
					dialogue_label.text = dialogue_text[dialogue_line][i]
				
			else:
				end_dialogue()


func end_dialogue() -> void:
	
	dialogue_timer.stop()
	dialogue_label.text = ""
	menue_select.visible = true
	dialogue_nde.visible = false
	dialogue_pressed = false
	current_state = states.MENUE
	dialogue_finished.emit()
