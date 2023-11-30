extends Area2D


@onready var anim_player: AnimationPlayer = $animation_player
@export var transition_position: Vector2 = Vector2(40, 88)


func player_animation() -> void:
	
	anim_player.play("door")
	await anim_player.animation_finished
	global.animation_finished.emit()
