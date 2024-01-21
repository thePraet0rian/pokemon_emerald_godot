extends Node2D


@onready var rooms: Node2D = $rooms
@onready var player: player
@onready var anim_player: AnimationPlayer = $animation_player
@onready var music_player: AudioStreamPlayer = $music_player

const battle_scn: PackedScene = preload("res://battle/battle.tscn")

signal transition_finished


const rooms_arr: Array = [preload("res://rooms/room_00.tscn"), preload("res://rooms/room_01.tscn"), preload("res://rooms/room_02.tscn"), 
preload("res://rooms/room_03.scn"), preload("res://rooms/room_04.tscn"), preload("res://rooms/room_05.tscn"), 
preload("res://rooms/room_06.tscn"), preload("res://rooms/room_07.tscn"), preload("res://rooms/room_08.tscn"),
preload("res://rooms/room_09.tscn"), preload("res://rooms/room_10.tscn")]



func _ready() -> void:
	
	set_process(false)
	start()
	
	global.connect("transition", Callable(self, "transition"))
	global.connect("start_battle", Callable(self, "start_battle"))
	global.connect("end_battle", Callable(self, "end_battle"))
	global.start_dialogue.connect(start_dialogue)
	global.end_dialogue.connect(end_dialogue)
	global.connect("start_game", Callable(self, "start_game"))
	global.connect("save_game", Callable(self, "save_game"))
	global.connect("enter_new_area", Callable(self, "enter_new_area"))
	
	global.object.connect(event)
	global.enable_player.connect(enable_player)


const save_path: String = "user://savefile.save"
var data: Array 


func start() -> void:
	
	anim_player.play("fade_out")
	
	data = FileAccess.open(save_path, FileAccess.READ).get_var().duplicate()
	
	global.current_room = data[0][0]
	
	rooms.add_child(rooms_arr[global.current_room].instantiate())
	
	var player_inst: CharacterBody2D = player_scn.instantiate()
	rooms.get_child(0).get_node("tilemap").add_child(player_inst)
	player_inst.position = data[0][1]
	player = $rooms.get_child(0).get_node("tilemap").get_node("player")
	
	global.player_pokemon.clear()
	global.player_pokemon.append_array(data[1])
	global.player_moveset.append_array(data[2])
	global.player_inventory.append_array(data[3])

	play_music()


@onready var sfx_player: AudioStreamPlayer = $sfx_player

const player_scn: PackedScene = preload("res://player/player.tscn")

var new_room_int: int = 0
var new_player_position: Vector2
var player_trans_inst
var transition_type: int
var room_inst: Node2D


func transition(new_room: int, next_position: Vector2, trans_type: int) -> void:
	
	player_trans_inst = player_scn.instantiate()
	player_trans_inst.position = next_position
	new_room_int = new_room
	global.current_room = new_room
	anim_player.play("fade_in")
	room_inst = rooms_arr[new_room].instantiate()
	transition_type = trans_type
	
	sfx_player.play()
	await sfx_player.finished


func end_transtition() -> void:
	
	
	if transition_type == 0:
		player.queue_free()
	
	rooms.get_child(0).queue_free()
	rooms.add_child(room_inst)
	
	
	await get_tree().create_timer(1).timeout
	
	rooms.get_child(0).get_node("tilemap").add_child(player_trans_inst)
	player = $rooms.get_child(0).get_node("tilemap").get_node("player")
	
	play_music()
	anim_player.play("fade_out")
	enter_new_area(global.current_area)
	transition_finished.emit()
	progress_transition(new_room_int)


func start_battle(enemy_pokemon: Array, enemy_moveset: Array, battle_type: int) -> void:
	
	stop_music()
	player = get_node("rooms").get_child(0).get_node("tilemap").get_child(0)
	player.process_mode = Node.PROCESS_MODE_DISABLED
	
	var battle_instance = battle_scn.instantiate()
	add_child(battle_instance)
	
	battle_instance.set_battle(enemy_pokemon, enemy_moveset, battle_type)


func end_battle() -> void:
	
	player.process_mode = Node.PROCESS_MODE_INHERIT
	get_node("battle").queue_free()
	play_music()


const dialogue_scn: PackedScene = preload("res://dialogue/dialogue_scn.tscn")

var dialogue_inst: CanvasLayer

func start_dialogue(text: Array, mode: bool) -> void:
	
	dialogue_inst = dialogue_scn.instantiate()
	dialogue_inst.set_text(text)
	dialogue_inst.set_mode(mode)
	add_child(dialogue_inst)


func end_dialogue(mode: bool) -> void:
	
	if mode:
		player.process_mode = Node.PROCESS_MODE_INHERIT
	
	dialogue_inst.queue_free()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	
	if anim_name == "fade_in":
		end_transtition()


func save_game() -> void:
	
	data.clear()
	print(data)
	data.append_array([[global.current_room, player.position], global.player_pokemon, global.player_moveset, global.player_inventory])
	print(data)
	
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(data)
	file.close()


func enable_player() -> void:
	
	player.process_mode = Node.PROCESS_MODE_INHERIT


func stop_music() -> void:
	
	music_player.stop()
	music_player.set_stream(null)


func play_music() -> void:
	
	match global.current_room:
		
		0:
			if !music_player.stream == load("res://sounds/1-05 Littleroot Town.mp3"):
				music_player.stream = load("res://sounds/1-05 Littleroot Town.mp3")
			else: return
		1:
			if !music_player.stream == load("res://sounds/1-05 Littleroot Town.mp3"):
				music_player.stream = load("res://sounds/1-05 Littleroot Town.mp3")
			else: return
		2:
			if !music_player.stream == load("res://sounds/1-05 Littleroot Town.mp3"):
				music_player.stream = load("res://sounds/1-05 Littleroot Town.mp3")
			else: return
		3:
			if !music_player.stream == load("res://sounds/1-05 Littleroot Town.mp3"):
				music_player.stream = load("res://sounds/1-05 Littleroot Town.mp3")
			else:
				return
	
	music_player.play()


func enter_new_area(new_area: int) -> void:
	
	var displayed_areas: Array = []
	var current_area: int = new_area
	
	match new_area:
		
		0:
			displayed_areas = [0, 1]
		1:
			displayed_areas = [0, 1, 2]
		2:
			displayed_areas = [1, 2, 3, 4]
		3:
			displayed_areas = [2, 3] # weird water connection
		4:
			displayed_areas = [2, 4, 5]
		5:
			displayed_areas = [4, 5, 6]
		6:
			displayed_areas = [6, 7, 9]
		7:
			displayed_areas = []
	
	global.current_area = current_area
	
	global.enter_new_room.emit(displayed_areas, current_area)


@onready var cutscene_player: AnimationPlayer = $cutscene_player
@onready var cutscene: Node2D = $cutscenes

@export var player_position: Vector2

const cutscenes: Array = [preload("res://cutscenes/cutscene_01.tscn"), preload("res://cutscenes/cutscene_02.tscn"), 
preload("res://cutscenes/cutscene_04.tscn"), "", preload("res://cutscenes/cutscene_06.tscn"), preload("res://cutscenes/cutscene_07.tscn"), "",
preload("res://cutscenes/cutscene_09.tscn"), preload("res://cutscenes/cutscene_10.tscn")]

var current_cutscene: Node2D
var events: Array = global.events


func progress_transition(new_room: int) -> void:
	
	var progress: int = global.progress
	
	match new_room:
		
		0:
			pass
		
		1:
			pass
		
		2:
			if !events[1]:
				
				cutscene_two()
				await transition_finished
				events[1] = true
			
			elif !events[2]:
				
				cutscene_four()
			
			elif !events[3]:
				
				cutscene_five()
				await transition_finished
				events[3] = true
			
		
		3:
			if !events[0]:
				
				leaving_the_van()
				await transition_finished
				events[0] = true
			
			elif !events[4]:
				
				cutscene_six()
			
			elif !events[7] and events[6]:
				
				cutscene_nine()
				cutscene_ten()
		
		4:
			
			if !events[5]:
				
				cutscene_seven()
		
		5:
			
			if !events[6]:
				
				cutscene_eight()



func leaving_the_van() -> void:
	
	cutscene.add_child(cutscenes[0].instantiate())
	current_cutscene = $cutscenes/cutscene_01
	
	player.process_mode = Node.PROCESS_MODE_DISABLED
	player.sprite.frame = 4
	current_cutscene.visible = true
	
	cutscene_player.play("cutscene_001")
	set_process(true)
	await cutscene_player.animation_finished
	set_process(false)
	
	start_dialogue([["Playerholder."]], true)
	await global.end_dialogue
	
	current_cutscene.play_animation("cutscene")
	
	player.get_node("anim_tree").active = false
	player.get_node("anim_player").play("walk_right")
	
	await get_tree().create_tween().tween_property(player, "position", player.position + Vector2(16, 0), .5).finished
	
	player.get_node("anim_player").stop()
	player.get_node("anim_player").play("walk_up")
	
	await get_tree().create_tween().tween_property(player, "position", player.position + Vector2(0, -32), 1).finished
	
	player.process_mode = Node.PROCESS_MODE_DISABLED
	
	transition(2, Vector2(40, 88), 0)
	await transition_finished
	
	$cutscenes/cutscene_01.queue_free()


func cutscene_two() -> void:
	
	rooms.get_child(0).cutscene()
	cutscene.add_child(cutscenes[1].instantiate())
	
	await transition_finished
	$cutscenes/cutscene_02.queue_free()


func cutscene_four() -> void:
	
	rooms.get_child(0).cutscene()
	cutscene.add_child(cutscenes[2].instantiate())
	
	start_dialogue([["Placeholder."]], false)
	await global.end_dialogue
	
	global.progress = 3
	transition(1, Vector2(24, 9), 0)
	await transition_finished
	$cutscenes/cutscene_04.queue_free()


func cutscene_five() -> void:
	
	start_dialogue([["Look your father was on tv."]], false)
	await global.end_dialogue


func cutscene_six() -> void:
	
	cutscene.add_child(cutscenes[4].instantiate())
	await global.transition
	cutscene.get_child(0).queue_free()


func cutscene_seven() -> void:
	
	player.process_mode = Node.PROCESS_MODE_DISABLED
	
	cutscene.add_child(cutscenes[5].instantiate())
	cutscene.get_child(0).cutscene()
	
	await get_tree().create_timer(1).timeout
	
	start_dialogue([["Placeholder."]], false)
	await global.end_dialogue
	
	events[5] = true
	
	await global.transition
	cutscene.get_child(0).queue_free()


func cutscene_eight() -> void:
	
	events[6] = true
	events[4] = true


func cutscene_nine() -> void:
	
	cutscene.add_child(cutscenes[7].instantiate())
	await global.transition
	cutscene.get_child(0).queue_free()


func cutscene_ten() -> void:
	
	cutscene.add_child(cutscenes[8].instantiate())
	
	await global.transition
	cutscene.get_child(0).queue_free()


func cutscene_eleven() -> void:
	
	await global.end_battle
	global.transition.emit(6, Vector2(8, -136), 0)
	events[7] = true


func home_pc() -> void:
	
	player.process_mode = Node.PROCESS_MODE_DISABLED
	add_child(home_pc_scn.instantiate())


func _process(_delta: float) -> void:
	
	player.position = player_position


const clock_scn: PackedScene = preload("res://components/set_clock.tscn")
const home_pc_scn: PackedScene = preload("res://components/home_pc/home_pc.tscn")


func event(action: String) -> void:
	
	match action:
		
		"clock_activated":
			player.process_mode = Node.PROCESS_MODE_DISABLED
			add_child(clock_scn.instantiate())
		"clock_set":
			events[2] = true
			player.process_mode = Node.PROCESS_MODE_INHERIT
		"a":
			global.start_battle.emit([[12, "Zigzagoon", ["Normal"], 12, 10, 10, 10, 10, 100, 12, 5, 125]], ["Pound"], 0)
			cutscene_eleven()
		"home_pc":
			home_pc()
