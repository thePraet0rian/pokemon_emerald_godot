extends Node2D


@onready var anim_player: AnimationPlayer = $animation_player


func cutscene() -> void:
	
	anim_player.play("cutscene")
