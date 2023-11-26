extends Node2D


@onready var rooms: Node2D = $rooms
@onready var player: CharacterBody2D
@onready var anim_player: AnimationPlayer = $animation_player
@onready var music_player: AudioStreamPlayer = $music_player

const battle_scn: PackedScene = preload("res://battle/battle.tscn")



const rooms_arr: Array = [preload("res://rooms/room_01.tscn"), preload("res://rooms/room_02.tscn"), 
preload("res://rooms/room_03.scn"), preload("res://rooms/room_04.tscn"), preload("res://rooms/room_05.tscn"), 
preload("res://rooms/room_06.tscn"), preload("res://rooms/room_07.tscn"), preload("res://rooms/room_08.tscn"),
preload("res://rooms/room_09.tscn"), preload("res://rooms/room_10.tscn")]



func _ready() -> void:
	
	start()
	
	global.connect("transition", Callable(self, "transition"))
	global.connect("start_battle", Callable(self, "start_battle"))
	global.connect("end_battle", Callable(self, "end_battle"))
	global.connect("start_dialogue", Callable(self, "start_dialogue"))
	global.connect("end_dialogue", Callable(self, "end_dialogue"))
	global.connect("start_game", Callable(self, "start_game"))
	global.connect("save_game", Callable(self, "save_game"))
	global.connect("enter_new_area", Callable(self, "enter_new_area"))


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
var player_inst
var room_inst: Node2D

func transition(new_room: int, next_position: Vector2) -> void:
	
	player_inst = player_scn.instantiate()
	player_inst.position = next_position
	new_room_int = new_room
	global.current_room = new_room
	anim_player.play("fade_in")
	room_inst = rooms_arr[new_room].instantiate()
	
	sfx_player.play()
	await sfx_player.finished


func end_transtition() -> void:
	
	player.queue_free()
	rooms.get_child(0).queue_free()
	rooms.add_child(room_inst)
	
	await get_tree().create_timer(1).timeout
	
	rooms.get_child(0).get_node("tilemap").add_child(player_inst)
	player = $rooms.get_child(0).get_node("tilemap").get_node("player")
	
	play_music()
	anim_player.play("fade_out")
	enter_new_area(0)


func start_battle(enemy_pokemon: Array, enemy_moveset: Array, battle_type: int) -> void:
	
	stop_music()
	
	var battle_instance = battle_scn.instantiate()
	add_child(battle_instance)
	
	battle_instance.set_battle(enemy_pokemon, enemy_moveset, battle_type)


func end_battle() -> void:
	
	player.process_mode = Node.PROCESS_MODE_INHERIT
	get_node("battle").queue_free()
	play_music()



const dialogue_scn: PackedScene = preload("res://dialogue/dialogue_scn.tscn")

var dialogue_inst: CanvasLayer

func start_dialogue(text: Array) -> void:
	
	dialogue_inst = dialogue_scn.instantiate()
	dialogue_inst.set_text(text)
	add_child(dialogue_inst)


func end_dialogue() -> void:
	
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


func stop_music() -> void:
	
	print("wait")
	
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
	
	music_player.play()


func enter_new_area(new_area: int) -> void:
	
	match new_area:
		
		0:
			global.emit_signal("enter_new_room", [0, 1], 0)
			return
		
		1:
			global.emit_signal("enter_new_room", [0, 1, 2], 1)
			return
		
		2:
			global.emit_signal("enter_new_room", [1, 2, 3, 4], 2)
			return
		
		3:
			global.emit_signal("enter_new_room", [2, 3, 3]) # Weird water connection TBI
			return
