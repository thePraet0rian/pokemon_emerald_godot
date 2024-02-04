extends CanvasLayer


enum states {MENUE = 0, FIGHT = 1, BAG = 2, POKEMON = 3, RUN = 4, DIALOUGE = 5, NONE = 6, ATTACKING = 7}


@onready var anim_player: AnimationPlayer = $anim_player
@onready var battle_anim_player: AnimationPlayer = $battle_anim_player


var player_pokemon: Array = global.player_pokemon
var player_moveset: Array = global.player_moveset

var enemy_pokemon: Array
var enemy_moveset: Array

var battle_type: int
var current_state: states = states.NONE


func set_battle(enemy_pokemon_arr: Array, enemy_moveset_arr: Array, battle_type_int: int) -> void:
	
	enemy_pokemon = enemy_pokemon_arr
	enemy_moveset = enemy_moveset_arr
	battle_type = battle_type_int
	
	start_battle()


@onready var menue_nde: Node2D = $menue
@onready var menue_label: Label = $menue/Label

@onready var enemy_sprite: Sprite2D = $ui/enemy_sprite
@onready var player_sprite: Sprite2D = $ui/player_sprite

@onready var player_name: Label = $info/player_info/name
@onready var enemy_name: Label = $info/enemy_info/name

@onready var player_hp_label: Label = $info/player_info/hp

@onready var enemy_lv_label: Label = $info/enemy_info/level
@onready var player_lv_label: Label = $info/player_info/level


const trainer_battle: int = 1
const wild_pokemon_battle: int = 0


func start_battle() -> void:
	
	set_ui()
	set_bag()
	set_pokemon()
	
	if battle_type == wild_pokemon_battle:
		wild_battle_intro()
	elif battle_type == trainer_battle:
		trainer_battle_intro()


func wild_battle_intro() -> void:
	
	anim_player.play("start")
	await anim_player.animation_finished
	
	start_dialouge(["Wild " + enemy_pokemon[0][1] + " appeared!\n", "Go " + player_pokemon[0][1] + "." ])
	await self.dialouge_finished
	
	anim_player.play("start_02")
	await anim_player.animation_finished
	
	battle_anim_player.play("constant")


func trainer_battle_intro() -> void:
	
	anim_player.play("start")
	await anim_player.animation_finished
	
	start_dialouge(["%s would like to battle!" % "LADY CINDY"]) 
	await self.dialouge_finished
	
	anim_player.play("start_02")
	await anim_player.animation_finished
	battle_anim_player.play("constant")


func set_ui() -> void:
	
	enemy_sprite.texture = pokemon_data.pokemon_front_sprite[global.get_mon_number(enemy_pokemon[0][1])]
	player_sprite.texture = pokemon_data.pokemon_back_sprite[global.get_mon_number(player_pokemon[0][1])]
	
	enemy_name.text = enemy_pokemon[0][1]
	player_name.text = player_pokemon[0][1]
	
	enemy_lv_label.text = "Lv" + str(enemy_pokemon[0][10])
	player_lv_label.text = "Lv" + str(player_pokemon[0][10])
	
	menue_label.text = "What will \n" + player_pokemon[0][1] + " do?"
	
	update_ui()


const item_scn: PackedScene = preload("res://components/item.tscn")


func set_bag() -> void:
	
	for i in range(5):
		for j in range(len(global.player_inventory[i])):
			
			var item_inst: Label = item_scn.instantiate()
			types[i].add_child(item_inst)
			item_inst.text = global.player_inventory[i][j][0]
			item_inst.position = Vector2(120, 24 + 16 * j)


@onready var pokemon_names: Array = [$pokemon/pokemon_01/name, $pokemon/pokemon_02/name, $pokemon/pokemon_03/name, $pokemon/pokemon_04/name, $pokemon/pokemon_05/name, $pokemon/pokemon_06/name]
@onready var pokemon_levels: Array = [$pokemon/pokemon_01/level, $pokemon/pokemon_02/level, $pokemon/pokemon_03/level, $pokemon/pokemon_04/level, $pokemon/pokemon_05/level, $pokemon/pokemon_06/level]
@onready var pokemon_hp: Array = [$pokemon/pokemon_01/hp, $pokemon/pokemon_02/hp, $pokemon/pokemon_03/hp, $pokemon/pokemon_04/hp, $pokemon/pokemon_05/hp, $pokemon/pokemon_06/hp]

@onready var pokeball: Array = [$pokemon/pokemon_01/sprite, $pokemon/pokemon_02/sprite2, $pokemon/pokemon_03/sprite2, $pokemon/pokemon_04/sprite2, $pokemon/pokemon_05/sprite2, $pokemon/pokemon_06/sprite2]
@onready var pokemons: Array = [$pokemon/pokemon_01, $pokemon/pokemon_02, $pokemon/pokemon_03, $pokemon/pokemon_04, $pokemon/pokemon_05, $pokemon/pokemon_06]

@onready var attack_label: Array = [[$attack_select/attack_01, $attack_select/attack_02], [$attack_select/attack_04, $attack_select/attack_03]]

const pokemon_normal_textures: Array = [preload("res://battle_assets/pokemon_switch/front_pokemon.png"), preload("res://battle_assets/pokemon_switch/other_pokemon.png"), preload("res://battle_assets/pokemon_switch/other_pokemon.png"), preload("res://battle_assets/pokemon_switch/other_pokemon.png"), preload("res://battle_assets/pokemon_switch/other_pokemon.png"), preload("res://battle_assets/pokemon_switch/other_pokemon.png")]
const pokemon_selected_textures: Array = [preload("res://battle_assets/pokemon_switch/front_pokemon.png"), preload("res://battle_assets/pokemon_switch/other_pokemon_selected.png"), preload("res://battle_assets/pokemon_switch/other_pokemon_selected.png"), preload("res://battle_assets/pokemon_switch/other_pokemon_selected.png"), preload("res://battle_assets/pokemon_switch/other_pokemon_selected.png"), preload("res://battle_assets/pokemon_switch/other_pokemon_selected.png")]


func set_pokemon() -> void:
	
	for i in range(len(player_pokemon)):
		
		pokemon_names[i].text = player_pokemon[i][1]
		pokemon_levels[i].text = "Lv" + str(player_pokemon[i][10])
		pokemon_hp[i].text = str(player_pokemon[i][3]) + "/" + str(player_pokemon[i][9])
		pokeball[i].visible = true
		pokemons[i].texture = pokemon_normal_textures[i]
	
	for i in range(len(player_moveset)):
		for j in range(len(player_moveset[i])):
			attack_label[i][j].text = player_moveset[i][j][0]


func _input(event: InputEvent) -> void:
	
	match current_state:
		
		states.MENUE:
			menue_input(event)
		states.FIGHT:
			attack_select_input(event)
		states.BAG:
			bag_input(event)
		states.POKEMON:
			pokemon_input(event)
#		states.RUN:
#			action(3, "Flee")
		states.DIALOUGE:
			dialouge_input(event)


@onready var menue_cursor: Sprite2D = $menue/menue_cursor

const menue_cursor_positions: Array = [[Vector2(147, 128), Vector2(203, 128)], [Vector2(147, 144), Vector2(203, 144)]]

var menue_cursor_index: Vector2i = Vector2i.ZERO


func menue_input(event: InputEvent) -> void:
	
	if event.is_action_pressed("move_left") and menue_cursor_index.x > 0:
		menue_cursor_index.x -= 1
	elif event.is_action_pressed("move_right") and menue_cursor_index.x < 1:
		menue_cursor_index.x += 1
	elif event.is_action_pressed("move_down") and menue_cursor_index.y < 1:
		menue_cursor_index.y += 1
	elif event.is_action_pressed("move_up") and menue_cursor_index.y > 0:
		menue_cursor_index.y -= 1
	
	menue_cursor.position = menue_cursor_positions[menue_cursor_index.y][menue_cursor_index.x]
	
	if event.is_action_pressed("space"):
		sfx_player.play()
		await sfx_player.finished
		
		match_menue_input()


func match_menue_input() -> void:
	
	if menue_cursor_index == Vector2i(0, 0):
		attack_select.visible = true
		current_state = states.FIGHT
	elif menue_cursor_index == Vector2i(1, 0):
		bag.visible = true
		current_state = states.BAG
	elif menue_cursor_index == Vector2i(0, 1):
		pokemon.visible = true
		current_state = states.POKEMON
	elif menue_cursor_index == Vector2i(1, 1):
		global.emit_signal("end_battle")


@onready var attack_select: Node2D = $attack_select
@onready var attack_select_cursor: Sprite2D = $attack_select/attack_select_cursor

var attack_select_index: Vector2i = Vector2i.ZERO
var attack_pressed: bool = false

const attack_select_cursor_positons: Array = [[Vector2(11, 128), Vector2(11, 146)], [Vector2(83, 128), Vector2(83, 146)]]


func attack_select_input(event: InputEvent) -> void:
	
	if event.is_action_pressed("move_left") and attack_select_index.x > 0:
		attack_select_index.x -= 1
	elif event.is_action_pressed("move_right") and attack_select_index.x < 1:
		attack_select_index.x += 1
	elif event.is_action_pressed("move_up") and attack_select_index.y > 0:
		attack_select_index.y -= 1
	elif event.is_action_pressed("move_down") and attack_select_index.y < 1:
		attack_select_index.y += 1
	
	pp_attack_label.text = "PP    " + str(player_moveset[attack_select_index.x][attack_select_index.y][1]) + "/" + str(attacks.attacks[player_moveset[attack_select_index.x][attack_select_index.y][0]][1])
	type_attack_label.text = "TYPE/" + attacks.attacks[player_moveset[attack_select_index.y][attack_select_index.y][0]][0]
	
	attack_select_cursor.position = attack_select_cursor_positons[attack_select_index.x][attack_select_index.y]
	
	if event.is_action_pressed("shift"):
		attack_select.visible = false
		current_state = states.MENUE
	elif event.is_action_pressed("space") and !attack_pressed:
		
		attack_pressed = true
		
		sfx_player.play()
		await sfx_player.finished
		
		battle_anim_player.stop()
		attack_select.visible = false
		current_state = states.NONE
		action(0, player_moveset[attack_select_index.x][attack_select_index.y][0])
		
		attack_pressed = false


@onready var bag: Node2D = $bag
@onready var bag_info: Sprite2D = $bag/info
@onready var bag_spr: Sprite2D = $bag/bag
@onready var point: Sprite2D = $bag/point
@onready var types: Array = [$bag/items, $bag/pokeballs, $bag/tm, $bag/berries, $bag/key_items]
@onready var bag_cursor: Sprite2D = $bag/bag_cursor

const bag_textures: Array = [preload("res://battle_assets/bag_assets/bag_01.png"), preload("res://battle_assets/bag_assets/bag_02.png"), preload("res://battle_assets/bag_assets/bag_03.png"), preload("res://battle_assets/bag_assets/bag_04.png"), preload("res://battle_assets/bag_assets/bag_05.png")]
const info_textures: Array = [preload("res://battle_assets/bag_assets/item_sign.png"), preload("res://battle_assets/bag_assets/pokeball_sign.png"), preload("res://battle_assets/bag_assets/tmandhm_sign.png"), preload("res://battle_assets/bag_assets/berries_sign.png"), preload("res://battle_assets/bag_assets/key_items_sign.png")]
const point_positions: Array = [Vector2(44, 29), Vector2(52, 29), Vector2(60, 29), Vector2(68, 29), Vector2(76, 29)]

var bag_index: Vector2i = Vector2i.ZERO
var bag_y_index: Array = [24, 24, 24, 24, 24]

func bag_input(event: InputEvent) -> void:
	
	if event.is_action_pressed("move_left"):
		if bag_index.x > 0:
			bag_index.x -= 1
		else:
			bag_index.x = 4
	elif event.is_action_pressed("move_right"):
		if bag_index.x < 4:
			bag_index.x += 1
		else:
			bag_index.x = 0
	elif event.is_action_pressed("move_up"):
		bag_y_index[bag_index.x] -= 16
	elif event.is_action_pressed("move_down"):
		bag_y_index[bag_index.x] += 16
	
	bag_spr.texture = bag_textures[bag_index.x]
	bag_info.texture = info_textures[bag_index.x]
	point.position = point_positions[bag_index.x]
	bag_cursor.position.y = bag_y_index[bag_index.x]
	
	if event.is_action_pressed("shift"):
		bag.visible = false
		current_state = states.MENUE
	elif event.is_action_pressed("space"):
		bag.visible = false
		current_state = states.NONE
		action(1, global.player_inventory[bag_index.x][bag_index.y][0])
	
	for i in range(len(types)):
		
		if bag_index.x == i:
			types[i].visible = true
		else:
			types[i].visible = false


@onready var pokemon: Node2D = $pokemon

var pokemon_index: int = 0


func pokemon_input(event: InputEvent) -> void:
	
	if event.is_action_pressed("move_left"):
		pass
	elif event.is_action_pressed("move_right"):
		pass
	
	if event.is_action_pressed("shift"):
		pokemon.visible = false
		current_state = states.MENUE
	elif event.is_action_pressed("space"):
		pokemon.visible = false
		current_state = states.NONE
		action(2, "0")


func action(player_action_index: int, player_action: String) -> void:
	
	var player_action_priority: int
	
	match player_action_index:
		0:
			player_action_priority = 0
		1:
			player_action_priority = 1
		2:
			player_action_priority = 2
		3:
			player_action_priority = 3
	
	var enemy_actions: Array = generate_enemy_action()
	
	var enemy_action_index: int = enemy_actions[0]
	var enemy_action: String = enemy_actions[1]
	
	var enemy_action_priority: int
	
	match enemy_action_index:
		0:
			enemy_action_priority = 0
		1:
			enemy_action_priority = 1
		2:
			enemy_action_priority = 2
		3:
			enemy_action_priority = 3
	
	if player_action_priority > enemy_action_priority:
		
		execute_action(0, [player_action_index, player_action], [enemy_action_index, enemy_action])
	elif player_action_priority == enemy_action_priority:
		
		if player_pokemon[0][7] >= enemy_pokemon[0][7]:
			execute_action(0, [player_action_index, player_action], [enemy_action_index, enemy_action])
		else:
			execute_action(1, [player_action_index, player_action], [enemy_action_index, enemy_action])
		
	elif player_action_priority < enemy_action_priority:
		
		execute_action(1, [player_action_index, player_action], [enemy_action_index, enemy_action])


func generate_enemy_action() -> Array: 
	
	return [0, "Tackle"]


signal action_finished_sig

var can: bool = true

const execute_methods_arr: Array = ["execute_attack", "execute_item", "execute_switch", "execute_flee"]
const player_first: int = 0
const enemy_first: int = 0


func execute_action(action_order_int: int, player_actions: Array, enemy_actions: Array) -> void:
	
	print(player_actions)
	print(enemy_actions)
	
	if action_order_int == player_first:
		
		self.call(execute_methods_arr[player_actions[0]], player_actions[1], 0)
		await self.action_finished_sig
		
		print("yes")
		
		if can:
			self.call(execute_methods_arr[enemy_actions[0]], enemy_actions[1], 1)
		else:
			can = true
			return
	
	elif action_order_int == enemy_first:
		
		self.call(execute_methods_arr[enemy_actions[0]], enemy_actions[1], 1)
		await self.action_finished_sig
		
		if can:
			self.call(execute_methods_arr[player_actions[0]], player_actions[1], 0)
		else:
			can = true
			return


var player_finished: bool = false
var enemy_finished: bool = false

const player_int: int = 0
const enemy_int: int = 1


func execute_attack(action_str: String, executer: int) -> void:
	
#	var hits: int = 100
	var damage: int
	
	var player_level: int = player_pokemon[0][10]
	var attacker_str: String
	var defender_str: String
	
	print("action:" + action_str)
	
	if executer == player_int:
		
		print("player_attack")
		
		attacker_str = player_pokemon[0][1]
		defender_str = enemy_pokemon[0][1]
		
		start_attack_dialouge([player_pokemon[0][1] + " used " + action_str + ".\n"])
		await dialouge_finished
		
		battle_anim_player.play("damage_enemy")
		playsound()
		
		match action_str:
			
			"Tackle":
				
				damage = damage(action_str, player_level, 7, attacker_str, defender_str)
				
				for i in range(damage * 10):
					
					await get_tree().create_timer(.01).timeout
					enemy_pokemon[0][9] -= .1
					update_ui()
			
			"Pound":
				
				damage = damage(action_str, player_level, 7, attacker_str, defender_str)
				
				for i in range(damage * 10):
					
					await get_tree().create_timer(.01).timeout
					enemy_pokemon[0][9] -= .1
					update_ui()
			
			"Quick Attack":
				
				damage = damage(action_str, player_level, 7, attacker_str, defender_str)
				
				for i in range(damage * 10):
					
					await get_tree().create_timer(.01).timeout
					enemy_pokemon[0][9] -= .1
					update_ui()
		
		
		attack_finished.emit()
		update()
		action_finished_sig.emit()
		battle_anim_player.stop()
		
		player_finished = true
		
	elif executer == enemy_int:
		
		print("enemy_attack")
		
		attacker_str = enemy_pokemon[0][1]
		defender_str = player_pokemon[0][1]
		
		start_attack_dialouge([enemy_pokemon[0][1] + " used " + action_str + ".\n"])
		await dialouge_finished
		
		battle_anim_player.play("damage_player")
		playsound()
		
		match action_str:
			
			"Absorb":
				
				damage = damage(action_str, enemy_pokemon[0][10], 7, enemy_pokemon[0][1], player_pokemon[0][1])
				
				for i in range(damage * 10):
					
					await get_tree().create_timer(.01).timeout
					player_pokemon[0][9] -= .1
					update_ui()
				
				for i in range((float(damage) / 2) * 10):
					
					await get_tree().create_timer(.01).timeout
					enemy_pokemon[0][9] += .1
					update_ui()
			
			"Acid":
				pass
			
			"Acid Armor":
				pass
			
			"Tackle":
				
				damage = damage(action_str, enemy_pokemon[0][10], 7, enemy_pokemon[0][1], player_pokemon[0][1])
				
				for i in range(damage * 10):
					
					await get_tree().create_timer(.01).timeout
					player_pokemon[0][9] -= .1
					update_ui()
			
			
			"Pound":
				
				damage = damage(action_str, enemy_pokemon[0][10], 20, enemy_pokemon[0][1], player_pokemon[0][1])
				
				for i in range(damage * 10):
					await get_tree().create_timer(.01).timeout
					player_pokemon[0][9] -= .1
					update_ui()
		
		
		attack_finished.emit()
		update()
		action_finished_sig.emit()
		battle_anim_player.stop()
		
		enemy_finished = true
	
	if player_finished and enemy_finished:
		
		battle_anim_player.play("constant")
		player_finished = false
		enemy_finished = false


func start_attack_dialouge(input_arr: Array) -> void:
	
	current_state = states.NONE
	
	dialouge_nde.visible = true
	dialouge_text = input_arr.duplicate()
	
	dialouge_line = 1
	dialouge_timer.start()
	
	for i in range(dialouge_line):
		for j in range(len(input_arr[i])):
			
			await dialouge_timer.timeout
			current_dialouge_str += input_arr[i][j]
			dialouge_label.text = current_dialouge_str
	
	await get_tree().create_timer(.5).timeout
	
	current_dialouge_str = ""
	dialouge_label.text = ""
	
	emit_signal("dialouge_finished")
	attacking()


signal attack_finished


func attacking() -> void:
	
	await attack_finished
	
	dialouge_nde.visible = false
	current_state = states.MENUE
	current_dialouge_str = ""
	dialouge_label.text = ""


@onready var enemy_hp_bar: ColorRect = $info/enemy_hp_bar
@onready var player_hp_bar: ColorRect = $info/player_hp_bar

@onready var pp_attack_label: Label = $attack_select/info/pp
@onready var type_attack_label: Label = $attack_select/info/type

@onready var xp_bar: ColorRect = $info/player_info/xp_bar

func update_ui() -> void:
	
	enemy_hp_bar.scale.x = float(enemy_pokemon[0][9] / enemy_pokemon[0][3])
	player_hp_bar.scale.x = float(player_pokemon[0][9] / player_pokemon[0][3])
	
	if player_pokemon[0][9] > (player_pokemon[0][3] / 2):
		player_hp_bar.color = Color8(0, 226, 22, 255)
	if player_pokemon[0][9] <= (player_pokemon[0][3] / 2):
		player_hp_bar.color = Color8(234, 209, 0, 255)
	if player_pokemon[0][9] <= (player_pokemon[0][3] / 5):
		player_hp_bar.color = Color8(234, 0, 0, 255)
	
	if enemy_pokemon[0][9] > (enemy_pokemon[0][3] / 2):
		enemy_hp_bar.color = Color8(0, 226, 22, 255)
	if enemy_pokemon[0][9] <= (enemy_pokemon[0][3] / 2):
		enemy_hp_bar.color = Color8(234, 209, 0, 255)
	if enemy_pokemon[0][9] <= (enemy_pokemon[0][3] / 5):
		enemy_hp_bar.color = Color8(234, 0, 0, 255)
	
	var min_xp: float = float(player_pokemon[0][11]) - float(cubed(player_pokemon[0][10]))
	var xp_to_next_level: float = float(cubed(player_pokemon[0][10] + 1)) - float(cubed(player_pokemon[0][10]))
	var xp_bar_scale: float = min_xp / xp_to_next_level
	xp_bar.scale.x = clampf(xp_bar_scale, 0.0, 1.0)
	
	player_hp_label.text = str(round(player_pokemon[0][9])) + "/" + str(player_pokemon[0][3])
	
	pp_attack_label.text = "PP    " + str(player_moveset[attack_select_index.x][attack_select_index.y][1]) + "/" + str(attacks.attacks[player_moveset[attack_select_index.x][attack_select_index.y][0]][1])
	type_attack_label.text = "TYPE/" + attacks.attacks[player_moveset[attack_select_index.y][attack_select_index.y][0]][0]


func cubed(input: int) -> float:
	
	return input * input * input


@onready var enemy_pokemon_left: int = len(enemy_pokemon)
@onready var player_pokemon_left: int = len(player_pokemon)

@onready var enemy_info: Sprite2D = $info/enemy_info



func update() -> void:
	
	if player_pokemon[0][9] <= 0:
		
		global.emit_signal("end_battle")
		
		can = false
		start_dialouge(["Pokemon fainted\n"])
		await dialouge_finished
		
	
	if enemy_pokemon[0][9] <= 0:
		
		can = false
		enemy_info.visible = false
		enemy_sprite.visible = false
		enemy_hp_bar.visible = false
		
		dialouge_nde.visible = true
		
		experience()
		await experience_end
		
		start_dialouge(["Pokemon fainted.\n", "Pokemon earned xp.\n"])
		await dialouge_finished
		
		
		global.emit_signal("end_battle")


signal experience_end


func experience() -> void:
	
	var xp: int = calc_experience(enemy_pokemon.duplicate())
	
	
	for i in range(xp):
		
		await get_tree().create_timer(.05).timeout
		player_pokemon[0][11] += 1
		
		update_ui()
	
	check_for_level_up()
	
	experience_end.emit()


func check_for_level_up() -> void:
	
	for i in range(len(player_pokemon)):
		
		if player_pokemon[i][11] >= cubed(player_pokemon[i][10] + 1):
			player_pokemon[i][10] += 1
			
			for j in range(3, 6):
				player_pokemon[i][j] += float(pokemon_data.pokemon[player_pokemon[i][0]][j - 1] / 50)
			


func calc_experience(pokemon_arr: Array) -> int: 
	
	var base_yield: float = pokemon_data.pokemon[pokemon_arr[0][0]][8]
	var type_of_battle: float
	var level: float = pokemon_arr[0][10]
	
	var participated: float = len(pokemon_arr)
	
	if battle_type == 0:
		type_of_battle = 1
	else:
		type_of_battle = 1.5
	
	return ceil(((base_yield * level) / 7) * (1 / (participated * 2)) * type_of_battle)


func damage(attack: String, level: int, crit_chance: int, attacker: String, defender: String) -> int: 
	
	var attack_power: int = attacks.attacks[attack][2]
	
	var attack_stat: int 
	var defense_stat: int 
	var phys: bool = true
	
	if phys:
		attack_stat = pokemon_data.pokemon[global.get_mon_number(attacker)][3]
		defense_stat = pokemon_data.pokemon[global.get_mon_number(defender)][4]
	else:
		attack_stat = pokemon_data.pokemon[global.get_mon_number(attacker)][5]
		defense_stat = pokemon_data.pokemon[global.get_mon_number(defender)][6]
	
	var crit: float = 1.0
	var stab: float = 1.0
	
	
	var crit_rand: int = randi_range(0, 100)
	if crit_rand < crit_chance:
		crit = 1.5
	
	if attacks.attacks[attack][0] in pokemon_data.pokemon[global.get_mon_number(attacker)][1]:
		stab = 1.5
	
	var type_01: float
	var type_02: float
	
	
	if len(pokemon_data.pokemon[global.get_mon_number(defender)][1]) == 1:
		
		type_01 = type_effectivness(attacks.attacks[attack][0], pokemon_data.pokemon[global.get_mon_number(defender)][1][0])
		type_02 = 1.0
	else:
		
		type_01 = type_effectivness(attacks.attacks[attack][0], pokemon_data.pokemon[global.get_mon_number(defender)][1][0])
		type_02 = type_effectivness(attacks.attacks[attack][0], pokemon_data.pokemon[global.get_mon_number(defender)][1][1])
	
	var random: float = 1
	
	
	@warning_ignore("integer_division", "narrowing_conversion")
	return ((((((2 * level) / 5) + 2) * attack_power * (attack_stat / defense_stat)) / 50) + 2) * stab * type_01 * type_02 * random * crit


func type_effectivness(attacking_type: String, defending_type: String) -> float:
	
	match attacking_type:
		
		"Normal":
			match defending_type:
				"Normal":
					return 1.0
				"Fighting":
					return 1.0
				"Flying":
					return 1.0
				"Poison":
					return 1.0
				"Ground":
					return 1.0
				"Rock":
					return .5
				"Bug":
					return 1.0
				"Ghost":
					return 0.0
				"Steel":
					return .5
				"Fire":
					return 1.0
				"Water":
					return 1.0
				"Grass":
					return 1.0
				"Electric":
					return 1.0
				"Psychic":
					return 1.0
				"Ice":
					return 1.0
				"Dragon":
					return 1.0
				"Dark":
					return 1.0
		
		"Fighting":
			match defending_type:
				"Normal":
					return 2.0
				"Fighting":
					return 1.0
				"Flying":
					return .5
				"Poison":
					return .5
				"Ground":
					return 1.0
				"Rock":
					return 2
				"Bug":
					return .5
				"Ghost":
					return 0.0
				"Steel":
					return 2
				"Fire":
					return 1.0
				"Water":
					return 1.0
				"Grass":
					return 1.0
				"Electric":
					return 1.0
				"Psychic":
					return .5
				"Ice":
					return 2
				"Dragon":
					return 1.0
				"Dark":
					return 2.0
		
		"Flying":
			
			match defending_type:
				"Normal":
					return 1.0
				"Fighting":
					return 2.0
				"Flying":
					return 1.0
				"Poison":
					return 1.0
				"Ground":
					return 1.0
				"Rock":
					return .5
				"Bug":
					return 2.0
				"Ghost":
					return 1.0
				"Steel":
					return .5
				"Fire":
					return 1.0
				"Water":
					return 1.0
				"Grass":
					return 2.0
				"Electric":
					return .5
				"Psychic":
					return 1.0
				"Ice":
					return 1.0
				"Dragon":
					return 1.0
				"Dark":
					return 1.0
		
		"Poison":
			match defending_type:
				"Normal":
					return 1.0
				"Fighting":
					return 1.0
				"Flying":
					return 1.0
				"Poison":
					return .5
				"Ground":
					return .5
				"Rock":
					return .5
				"Bug":
					return 1.0
				"Ghost":
					return 0.5
				"Steel":
					return 0.0
				"Fire":
					return 1.0
				"Water":
					return 1.0
				"Grass":
					return 2.0
				"Electric":
					return 1.0
				"Psychic":
					return 1.0
				"Ice":
					return 1.0
				"Dragon":
					return 1.0
				"Dark":
					return 1.0
		
		"Ground":
			match defending_type:
				"Normal":
					return 1.0
				"Fighting":
					return 1.0
				"Flying":
					return 0.0
				"Poison":
					return 2.0
				"Ground":
					return 1.0
				"Rock":
					return 2.0
				"Bug":
					return .5
				"Ghost":
					return 1.0
				"Steel":
					return 2.0
				"Fire":
					return 2.0
				"Water":
					return 1.0
				"Grass":
					return .5
				"Electric":
					return 2.0
				"Psychic":
					return 1.0
				"Ice":
					return 1.0
				"Dragon":
					return 1.0
				"Dark":
					return 1.0
		
		"Rock":
			match defending_type:
				"Normal":
					return 1.0
				"Fighting":
					return .5
				"Flying":
					return 2.0
				"Poison":
					return 1.0
				"Ground":
					return .5
				"Rock":
					return 2.0
				"Bug":
					return 2
				"Ghost":
					return 1.0
				"Steel":
					return .5
				"Fire":
					return 2.0
				"Water":
					return 1.0
				"Grass":
					return 1
				"Electric":
					return 2.0
				"Psychic":
					return 1.0
				"Ice":
					return 2.0
				"Dragon":
					return 1.0
				"Dark":
					return 1.0
		
		"Bug":
			match defending_type:
				"Normal":
					return 1.0
				"Fighting":
					return .5
				"Flying":
					return .5
				"Poison":
					return .5
				"Ground":
					return 1.0
				"Rock":
					return 1.0
				"Bug":
					return 1.0
				"Ghost":
					return .5
				"Steel":
					return .5
				"Fire":
					return .5
				"Water":
					return 1.0
				"Grass":
					return 2.0
				"Electric":
					return 1.0
				"Psychic":
					return 2.0
				"Ice":
					return 1.0
				"Dragon":
					return 1.0
				"Dark":
					return 2.0
		
		"Ghost":
			match defending_type:
				"Normal":
					return 0.0
				"Fighting":
					return 1.0
				"Flying":
					return 1.0
				"Poison":
					return 1.0
				"Ground":
					return 1.0
				"Rock":
					return 1.0
				"Bug":
					return 1.0
				"Ghost":
					return 2.0
				"Steel":
					return .5
				"Fire":
					return 1.0
				"Water":
					return 1.0
				"Grass":
					return 1.0
				"Electric":
					return 1.0
				"Psychic":
					return 2.0
				"Ice":
					return 1.0
				"Dragon":
					return 1.0
				"Dark":
					return .5
		
		"Steel":
			match defending_type:
				"Normal":
					return 1
				"Fighting":
					return 1
				"Flying":
					return 1
				"Poison":
					return 1
				"Ground":
					return 1
				"Rock":
					return 2
				"Bug":
					return 1
				"Ghost":
					return 1
				"Steel":
					return .5
				"Fire":
					return .5
				"Water":
					return .5
				"Grass":
					return 1
				"Electric":
					return .5
				"Psychic":
					return 1.0
				"Ice":
					return 2.0
				"Dragon":
					return 1.0
				"Dark":
					return 1.0
		
		"Fire":
			match defending_type:
				"Normal":
					return 1.0
				"Fighting":
					return 1.0
				"Flying":
					return 1
				"Poison":
					return 1
				"Ground":
					return 1
				"Rock":
					return .5
				"Bug":
					return 2
				"Ghost":
					return 1.0
				"Steel":
					return 2.0
				"Fire":
					return .5
				"Water":
					return .5
				"Grass":
					return 2
				"Electric":
					return 1
				"Psychic":
					return 1
				"Ice":
					return 2
				"Dragon":
					return .5
				"Dark":
					return 1.0
		
		"Water":
			match defending_type:
				"Normal":
					return 1.0
				"Fighting":
					return 1.0
				"Flying":
					return 1
				"Poison":
					return 1
				"Ground":
					return 2.0
				"Rock":
					return 2.0
				"Bug":
					return 1
				"Ghost":
					return 1.0
				"Steel":
					return 1.0
				"Fire":
					return 2.0
				"Water":
					return .5
				"Grass":
					return .5
				"Electric":
					return 1.0
				"Psychic":
					return 1.0
				"Ice":
					return 1.0
				"Dragon":
					return .5
				"Dark":
					return 1.0
		
		"Grass":
			match defending_type:
				"Normal":
					return 1.0
				"Fighting":
					return 1.0
				"Flying":
					return 0.5
				"Poison":
					return 0.5
				"Ground":
					return 2.0
				"Rock":
					return 2.0
				"Bug":
					return 0.5
				"Ghost":
					return 1.0
				"Steel":
					return .5
				"Fire":
					return .5
				"Water":
					return 2.0
				"Grass":
					return .5
				"Electric":
					return 1.0
				"Psychic":
					return 1.0
				"Ice":
					return 1.0
				"Dragon":
					return .5
				"Dark":
					return 1.0
		
		"Electric":
			match defending_type:
				"Normal":
					return 1.0
				"Fighting":
					return 1.0
				"Flying":
					return 2.0
				"Poison":
					return 1.0
				"Ground":
					return 0.0
				"Rock":
					return 1.0
				"Bug":
					return 1
				"Ghost":
					return 1.0
				"Steel":
					return 1.0
				"Fire":
					return 1.0
				"Water":
					return 2.0
				"Grass":
					return .5
				"Electric":
					return .5
				"Psychic":
					return 1.0
				"Ice":
					return 1.0
				"Dragon":
					return .5
				"Dark":
					return 1.0
		
		"Psychic":
			match defending_type:
				"Normal":
					return 1.0
				"Fighting":
					return 2
				"Flying":
					return 1.0
				"Poison":
					return 2.0
				"Ground":
					return 1.0
				"Rock":
					return 1.0
				"Bug":
					return 1
				"Ghost":
					return 1.0
				"Steel":
					return .5
				"Fire":
					return 1.0
				"Water":
					return 1.0
				"Grass":
					return 1
				"Electric":
					return 1.0
				"Psychic":
					return .5
				"Ice":
					return 1.0
				"Dragon":
					return 1.0
				"Dark":
					return 0
		
		"Ice":
			match defending_type:
				"Normal":
					return 1.0
				"Fighting":
					return 1.0
				"Flying":
					return 2.0
				"Poison":
					return 1.0
				"Ground":
					return 2.0
				"Rock":
					return 1.0
				"Bug":
					return 1
				"Ghost":
					return 1
				"Steel":
					return .5
				"Fire":
					return .5
				"Water":
					return .5
				"Grass":
					return 2
				"Electric":
					return 1
				"Psychic":
					return 1.0
				"Ice":
					return .5
				"Dragon":
					return 2
				"Dark":
					return 1.0
		
		"Dragon":
			match defending_type:
				"Normal":
					return 1.0
				"Fighting":
					return 1.0
				"Flying":
					return 1
				"Poison":
					return 1.0
				"Ground":
					return 1.0
				"Rock":
					return 1.0
				"Bug":
					return 1
				"Ghost":
					return 1.0
				"Steel":
					return .5
				"Fire":
					return 1.0
				"Water":
					return 1.0
				"Grass":
					return 1
				"Electric":
					return 1.0
				"Psychic":
					return 1.0
				"Ice":
					return 1.0
				"Dragon":
					return 2.0
				"Dark":
					return 1.0
		
		"Dark":
			match defending_type:
				"Normal":
					return 1.0
				"Fighting":
					return .5
				"Flying":
					return 1.0
				"Poison":
					return 1.0
				"Ground":
					return 1.0
				"Rock":
					return 1.0
				"Bug":
					return 1
				"Ghost":
					return 2.0
				"Steel":
					return .5
				"Fire":
					return 1.0
				"Water":
					return 1.0
				"Grass":
					return 1
				"Electric":
					return 1.0
				"Psychic":
					return 2.0
				"Ice":
					return 1.0
				"Dragon":
					return 1.0
				"Dark":
					return .5
	
	return 1.0


func execute_item(_action: String, _executer: int) -> void:
	current_state = states.MENUE


func execute_switch(_action: String, _executer: int) -> void:
	current_state = states.MENUE


func execute_flee(_action: String, _exectuer: int) -> void:

	current_state = states.MENUE
	global.emit_signal("end_battle")


signal dialouge_finished()

@onready var dialouge_nde: Node2D = $dialouge
@onready var dialouge_timer: Timer = $dialouge/timer
@onready var dialouge_label: Label = $dialouge/text_label

var dialouge_text: Array
var dialouge_line: int
var current_dialouge_str: String = ""
var dialouge_pressed: bool = false


func start_dialouge(input_arr: Array) -> void:
	
	dialouge_pressed = true
	current_state = states.NONE
	
	dialouge_nde.visible = true
	dialouge_text = input_arr.duplicate()
	
	dialouge_line = 1
	dialouge_timer.start()
	
	for i in range(dialouge_line):
		for j in range(len(input_arr[i])):
			
			await dialouge_timer.timeout
			current_dialouge_str += input_arr[i][j]
			dialouge_label.text = current_dialouge_str
	
	current_state = states.DIALOUGE
	dialouge_pressed = false


@onready var sfx_player: AudioStreamPlayer = $sfx_player


func dialouge_input(event: InputEvent) -> void:
	
	if !dialouge_pressed:
		if event.is_action_pressed("space"):
			
			dialouge_pressed = true
			
			sfx_player.play()
			await sfx_player.finished
			
			
			if dialouge_line < len(dialouge_text):
				
				current_dialouge_str = current_dialouge_str.erase(0, current_dialouge_str.find("\n") + 1)
				dialouge_label.text = current_dialouge_str
				
				if current_dialouge_str.find("\n") == -1:
					
					for i in range(len(dialouge_text[dialouge_line])):
						
						await dialouge_timer.timeout
						current_dialouge_str += dialouge_text[dialouge_line][i]
						dialouge_label.text = current_dialouge_str
					
				else:
					pass
				
				dialouge_line += 1
				dialouge_pressed = false
				
			else:
				
				end_dialouge()


func end_dialouge() -> void:
	
	dialouge_timer.stop()
	current_dialouge_str = ""
	dialouge_label.text = ""
	menue_nde.visible = true
	dialouge_nde.visible = false
	dialouge_pressed = false
	current_state = states.MENUE
	dialouge_finished.emit()


@onready var audio_stream_player: AudioStreamPlayer = $audio_stream_player


func playsound() -> void:
	
	audio_stream_player.play()
