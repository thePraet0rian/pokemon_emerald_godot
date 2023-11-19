extends Node


signal transition()
signal start_battle()
signal end_battle()
signal lost_battle()
signal start_dialogue()
signal end_dialogue()
signal start_game()
signal save_game


const rooms: Array = [preload("res://rooms/room_01.tscn"), preload("res://rooms/room_02.tscn"), 
preload("res://rooms/room_03.scn"), preload("res://rooms/room_04.tscn"), preload("res://rooms/room_05.tscn"), 
preload("res://rooms/room_06.tscn"), preload("res://rooms/room_07.tscn"), preload("res://rooms/room_08.tscn"),
preload("res://rooms/room_09.tscn"), preload("res://rooms/room_10.tscn")]

var current_room: int = 0

var player_pokemon: Array = []
var player_moveset: Array = []

var player_inventory: Array = []


func _ready() -> void:
	
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func get_mon_number(pokemon_name: String) -> int:
	
	for i in range(len(pokemon_data.pokemon)):
		
		if pokemon_name == pokemon_data.pokemon[i][0]:
			return i
	
	return 0


