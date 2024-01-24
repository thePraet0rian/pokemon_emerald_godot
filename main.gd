extends Node2D
class_name main
## Main script for pokemon emerald

@onready var anim_player: AnimationPlayer = $animation_player
@onready var sfx_player: AudioStreamPlayer = $sfx_player
@onready var rooms: Node2D = $rooms


func _ready() -> void:
	
	start()
	connect_signals() 


const save_path: String = "user://savefile.save"
const player_scn: PackedScene = preload("res://player/player.tscn")
const rooms_arr: Array[PackedScene] = [preload("res://rooms/room_00.tscn"), preload("res://rooms/room_01.tscn"), preload("res://rooms/room_02.tscn"), preload("res://rooms/room_03.scn"), preload("res://rooms/room_04.tscn"), preload("res://rooms/room_05.tscn"), preload("res://rooms/room_06.tscn"), preload("res://rooms/room_07.tscn"), preload("res://rooms/room_08.tscn"),preload("res://rooms/room_09.tscn"), preload("res://rooms/room_10.tscn")]

var saved_data: Array
var player_inst: player


func start() -> void:
	
	anim_player.play("fade_out")
	
	saved_data = FileAccess.open(save_path, FileAccess.READ).get_var().duplicate()
	print(saved_data)
	
	global.current_room = saved_data[0][0]
	global.current_area = saved_data[0][2]
	rooms.add_child(rooms_arr[saved_data[0][0]].instantiate())
	
	player_inst = player_scn.instantiate()
	rooms.get_child(0).get_node("tilemap").add_child(player_inst)
	
	if saved_data[0][0] == 3:
		_on_enter_new_route(global.current_area)
	
	player_inst.position = saved_data[0][1]
	
	global.player_pokemon.clear()
	global.player_pokemon.append_array(saved_data[1])
	global.player_moveset.append_array(saved_data[2])
	global.player_inventory.append_array(saved_data[3])
	
	play_room_music()


@onready var music_player: AudioStreamPlayer = $music_player


func play_room_music() -> void:
	
	match global.current_room:
		
		0:
			if !music_player.stream == load("res://sounds/1-05 Littleroot Town.mp3"):
				music_player.stream = load("res://sounds/1-05 Littleroot Town.mp3")
		1:
			if !music_player.stream == load("res://sounds/1-05 Littleroot Town.mp3"):
				music_player.stream = load("res://sounds/1-05 Littleroot Town.mp3")
		2:
			if !music_player.stream == load("res://sounds/1-05 Littleroot Town.mp3"):
				music_player.stream = load("res://sounds/1-05 Littleroot Town.mp3")
		3:
			if !music_player.stream == load("res://sounds/1-05 Littleroot Town.mp3"):
				music_player.stream = load("res://sounds/1-05 Littleroot Town.mp3")
	
	music_player.play()


func play_route_music() -> void: #TODO: Implement the route music player
	pass 


func connect_signals() -> void:
	
	global.transition.connect(_on_transition_sig)
	
	global.start_battle.connect(_on_start_battle_sig)
	global.end_battle.connect(_on_end_battle_sig)
	
	global.start_dialogue.connect(_on_start_dialogue_sig)
	global.end_dialogue.connect(_on_end_dialogue_sig)
	
	global.save_game.connect(_on_save_game_sig)
	
	global.enter_new_area.connect(_on_enter_new_route)


var new_room: int 
var room_inst: Node2D
var trans_type: int
var next_position: Vector2


func _on_transition_sig(_new_room: int, _next_position: Vector2, _trans_type: int) -> void:
	
	next_position = _next_position
	new_room = _new_room
	
	global.current_room = _new_room
	
	anim_player.play("fade_in")
	
	room_inst = rooms_arr[new_room].instantiate()
	trans_type = _trans_type
	
	sfx_player.play() 
	
	await anim_player.animation_finished
	end_transtition()


func end_transtition() -> void:
	
	if trans_type == 0:
		player_inst.queue_free()
	
	rooms.get_child(0).queue_free()
	rooms.add_child(room_inst)
	
	await get_tree().create_timer(.5).timeout
	
	player_inst = player_scn.instantiate()
	player_inst.position = next_position
	rooms.get_child(0).get_node("tilemap").add_child(player_inst)
	
	play_room_music()
	anim_player.play("fade_out")
	
	_on_enter_new_route(global.current_area)
	#transition_finished.emit()
	#progress_transition(new_room_int)


func _on_enter_new_route(_area: int) -> void:
	
	var displayed_areas: Array = []
	var current_area: int = _area
	
	match _area:
		
		0:
			displayed_areas = [0, 1]
		1:
			displayed_areas = [0, 1, 2]
		2:
			displayed_areas = [1, 2, 3, 4]
		3:
			displayed_areas = [2, 3] #TODO: weird water connection
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


const battle_scn: PackedScene = preload("res://battle/battle.tscn")


func _on_start_battle_sig(_enemy_pokemon: Array, _enemy_moveset: Array, _battle_type: int) -> void:
	
	stop_music()
	player_inst.process_mode = Node.PROCESS_MODE_DISABLED
	
	var battle_instance = battle_scn.instantiate()
	add_child(battle_instance)
	
	battle_instance.set_battle(_enemy_pokemon, _enemy_moveset, _battle_type)


func _on_end_battle_sig() -> void:
	
	player.process_mode = Node.PROCESS_MODE_INHERIT
	get_node("battle").queue_free()
	play_room_music()


const dialogue_scn: PackedScene = preload("res://dialogue/dialogue_scn.tscn")

var dialogue_inst: CanvasLayer


func _on_start_dialogue_sig(_text: Array, _mode: bool) -> void:
	
	dialogue_inst = dialogue_scn.instantiate()
	dialogue_inst.set_text(_text)
	dialogue_inst.set_mode(_mode)
	add_child(dialogue_inst)


func _on_end_dialogue_sig(_mode: bool) -> void:
	
	if _mode:
		player_inst.process_mode = Node.PROCESS_MODE_INHERIT
	
	dialogue_inst.queue_free()


var save_data: Array = []

func _on_save_game_sig() -> void:
	
	save_data.append_array([[global.current_room, player_inst.position, global.current_area], global.player_pokemon, global.player_moveset, global.player_inventory])
	print(save_data)
	
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(save_data)
	file.close()


func stop_music() -> void:
	
	music_player.stop()


var events: Array = global.events


func unique_room_events(room: int) -> void:
	
	match room:
		0:
			pass
			
		1:
			pass
		
		2:
			if !events[1]:
				
				pass
				#cutscene_two()
				#await transition_finished
				#events[1] = true
			
			elif !events[2]:
				
				pass
				#cutscene_four()
			
			elif !events[3]:
				
				pass
				#cutscene_five()
				#await transition_finished
				#events[3] = true
			
		
		3:
			if !events[0]:
				
				pass
				#leaving_the_van()
				#await transition_finished
				#events[0] = true
			
			elif !events[4]:
				
				pass
				#cutscene_six()
			
			elif !events[7] and events[6]:
				
				pass
				#cutscene_nine()
				#cutscene_ten()
		
		4:
			
			if !events[5]:
				
				pass
				#cutscene_seven()
		
		5:
			
			if !events[6]:
				
				pass
				#cutscene_eight()

"""
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
"""
