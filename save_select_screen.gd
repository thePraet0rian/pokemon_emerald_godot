extends Node2D

enum states {normal, options}

@onready var play_sprite: Sprite2D = $sprite_2d
@onready var options_sprite: Sprite2D = $sprite_2d_2
@onready var sfx_player: AudioStreamPlayer = $sfx_player
@onready var options: Node2D = $options

const textures: Array = [preload("res://titlescreen_assets/load_game.png"), preload("res://titlescreen_assets/load_game_selected.png"), preload("res://titlescreen_assets/options.png"), preload("res://titlescreen_assets/options_selected.png")]
const save_path: String = "user://savefile.save"
const main: PackedScene = preload("res://main.tscn")

var data: Array = [[3, Vector2(8, 40), 0], [[[global.get_mon_number("Treecko"), "Treecko", ["Grass"], 19.0, 11.0, 10.0, 11.0, 20, 10.0, 19, 5, 125], [[["Pound", 35], ["Absorb", 20]], [["Leer", 30], ["Quick Attack", 30]]]], [[global.get_mon_number("Rayquaza"), "Rayquaza", ["Dragon"], 100, 100, 100, 100, 100, 100, 100, 100, 100], [[["Pound", 35], ["Leer", 20]]]]], [[["CLOSE BAG", -1], ["Potion", 2]], [["CLOSE BAG", -1]], [["CLOSE BAG", -1]], [["CLOSE BAG", -1]], [["CLOSE BAG", -1]]]]
var index: int = 0
var current_state: states = states.normal


func _input(event: InputEvent) -> void:
	
	if current_state == states.normal:
		if event.is_action_pressed("move_down") and index < 1:
			index += 1
		elif event.is_action_pressed("move_up") && (index > 0):
			index -= 1
		
		if index == 0:
			play_sprite.texture = textures[0]
			options_sprite.texture = textures[3]
		else:
			options_sprite.texture = textures[2]
			play_sprite.texture = textures[1]
		
		if event.is_action_pressed("space"):
			execute()
		
	elif current_state == states.options:
		
		if event.is_action_pressed("shift"):
			
			current_state = states.normal
			options.visible = false


@onready var anim_player: AnimationPlayer = $animation_player


func execute() -> void:
	
	sfx_player.play()
	await sfx_player.finished
	
	if index == 0:
		
		var file = FileAccess.open(save_path, FileAccess.WRITE)
		file.store_var(data)
		anim_player.play("fade")
		await anim_player.animation_finished
		
		get_tree().change_scene_to_packed(main)
		queue_free()
		
	else:
		
		current_state = states.options
		options.visible = true 
