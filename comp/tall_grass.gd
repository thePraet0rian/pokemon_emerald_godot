extends Area2D


const wild_battle: int = 0

@export var pokemon_name_arr: Array = []


@onready var anim_player: AnimationPlayer = $anim_player

func player_anim() -> void: 
	anim_player.play("fade")
