extends Node


signal transition()
signal enter_new_room()

signal enter_new_area()
signal update_area()

signal entered_new_route()
signal update_routes()

signal start_battle()
signal end_battle()
signal lost_battle()

signal start_dialogue()
signal end_dialogue()

signal start_game()
signal save_game

signal animation_finished

signal object()

signal enable_player

signal nurse()
signal player_area_update

var player_name: String = "Johannes"

var current_room: int = 0
var current_area: int = 0
var display_areas: Array = []

var player_pokemon: Array = []
var player_moveset: Array = []

var player_inventory: Array = []
var global_pc_storage: Array[Array] = [["Potion", 1], ["Potion", 1], ["Potion", 1], ["Potion", 1], ["Potion", 1], ["Potion", 1], ["Potion", 1], ["Potion", 1], ["Potion", 1]]

var progress: int = 0
var debug: bool = true
var time: int = 0

var events: Array[bool] = [false, false, false, false, false, false, false, false, false]


func get_mon_number(pokemon_name: String) -> int:
	
	for i in range(len(pokemon_data.pokemon)):
		
		if pokemon_name == pokemon_data.pokemon[i][0]:
			return i
	
	return 0
