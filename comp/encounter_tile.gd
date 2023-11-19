extends Area2D


const wild_pokemon_battle: int = 0

@export var pokemon_names: Array = ["", "", "", "", "", ""]
@export var pokemon_levels: Array = [0, 0, 0, 0, 0, 0]
@export var pokemon_chance: Array = [0, 0, 0, 0, 0, 0]
@export var tile_density: int = 320

@onready var anim_player: AnimationPlayer = $anim_player

var pokemon_arr: Array = [[]]
var pokemon_name: String
var pokemon_level: int
var pokemon_stats: Array
var pokemon_moveset: Array

var disabled: bool = false
var entered: bool = false

var player: CharacterBody2D
var modifire: float = 1.0


func _ready() -> void:
	set_process(false)


func _on_body_entered(body: Node2D) -> void:
	
	if body.name == "player" and !disabled:
		anim_player.play("fade")
		player = body
		set_process(true)


func _process(_delta: float) -> void:
	
	print("yes")
	
	if !player.is_moving:
		if pokemon_encounterd():
			
			set_process(false)
			player.process_mode = Node.PROCESS_MODE_DISABLED
			await get_tree().create_timer(.5).timeout
			start_battle()
			disabled = true
			
		else:
			
			set_process(false)


func pokemon_encounterd() -> bool:
	
	("encounterd")
	randomize()
	var tile_barrier = randi_range(0, 2879)
	
	if tile_barrier <= tile_density * modifire:
		
		
		randomize()
		var rand: int = randi_range(0, 100)
		
		for i in range(len(pokemon_names)):
			
			if rand <= pokemon_chance[i]:
				
				pokemon_name = pokemon_names[i]
				pokemon_level = pokemon_levels[i]
				
				return true
	
	return false


func start_battle() -> void:
	
	randomize()
	
	pokemon_arr[0].append(global.get_mon_number(pokemon_name))
	pokemon_arr[0].append(pokemon_name)
	pokemon_arr[0].append(pokemon_data.pokemon[pokemon_arr[0][0]][1])
	
	var pokemon: Array = pokemon_data.pokemon[pokemon_arr[0][0]].duplicate()
	
	var hp_stat: int
	var dv_hp = randi_range(0, 15)
	
	hp_stat = floor(((pokemon[2] + dv_hp) * 2) + pokemon_level) / 100 + pokemon_level + 10
	pokemon_arr[0].append(hp_stat)
	
	var other_stat: int = 0
	
	for j in range(1, 6):
		var dv_other: int = randi_range(0, 15)
		
		other_stat = (floor(((pokemon[j + 2] + dv_other) * 2) + pokemon_level) / 100) + 5
		pokemon_arr[0].append(other_stat)
	
	pokemon_arr[0].append(hp_stat)
	pokemon_arr[0].append(pokemon_level)
	
	
	
	global.emit_signal("start_battle", pokemon_arr, pokemon_moveset, wild_pokemon_battle)
	reset()


func reset() -> void:
	
	pokemon_arr = [[]]
	pokemon_moveset = [[]]


func _on_body_exited(_body: Node2D) -> void:
	disabled = false
