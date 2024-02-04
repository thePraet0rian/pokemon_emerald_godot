extends Node2D


func _ready() -> void:
	
	global.nurse.connect(_on_nurse_sig)


@onready var dialogue_layer_nde: dialogue_layer = $dialogue
@onready var option_selection_nde: option_selection = $option_selection
@onready var anim_player: AnimationPlayer = $anim_player


func _on_nurse_sig(_pokemon_count: int) -> void:
	
	global.start_dialogue.emit(["Hello, and welcome to \nthe Pokemon Center.", "We restore your tired Pokemon to full health."], false)
	await global.end_dialogue
	
	dialogue_layer_nde.visible = true
	dialogue_layer_nde.dialogue_write("Would you like to rest your Pokemon?")
	await dialogue_layer_nde.write_finished
	
	option_selection_nde.visible = true
	option_selection_nde.activated = true
	
	option_selection_nde.selection.connect(_on_selection)


func _on_selection(selection: bool) -> void:
	
	option_selection_nde.selection.disconnect(_on_selection)
	
	if !selection:
		
		reset()
		global.start_dialogue.emit(["We hope to see you again"], true)
		await global.end_dialogue
	else:
		
		dialogue_layer_nde.reset()
		dialogue_layer_nde.dialogue_write("Okay, I will take your Pokemon for a few seconds.")
		await dialogue_layer_nde.write_finished
		anim_player.play("1")
		await anim_player.animation_finished
		
		global.start_dialogue.emit(["Thank you for waiting.", "We have restored your pokemon to full health again", "We hope to see you again"], true)
		queue_free()


func reset() -> void:
	
	dialogue_layer_nde.visible = false
	dialogue_layer_nde.reset()
	option_selection_nde.visible = false
