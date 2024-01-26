extends Node2D


const save_select_screen: PackedScene = preload("res://save_select_screen.tscn")

@onready var animation_player: AnimationPlayer = $animation_player

var animation_playing : String = "start"


func _ready() -> void: 
	
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _input(event: InputEvent) -> void:
	
	if event.is_action_pressed("space"):
			
		if animation_playing == "start":
			animation_player.stop()
			animation_player.play("cycle")
			animation_playing = "cycle"
		else:
			
			var save_select_inst: Node2D = save_select_screen.instantiate()
			get_parent().add_child(save_select_inst)
			queue_free()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	
	if anim_name == "start":
		animation_player.play("cycle")
		animation_playing = "cycle"

