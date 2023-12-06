extends Node2D


@onready var anim_player: AnimationPlayer = $animation_player


func play_animation(animation: String) -> void:
	
	anim_player.play(animation)
