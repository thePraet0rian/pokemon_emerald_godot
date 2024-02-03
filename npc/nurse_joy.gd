extends Node2D



func _ready() -> void:
	
	global.nurse.connect(_on_nurse_sig)


func _on_nurse_sig(pokemon_count: int) -> void:
	
	global.start_dialogue.emit([["Hello, and welcome to \nthe Pokemon Center."], ["We restore your tired Pokemon to full health."], ["Would you like to rest your Pokemon?"]], false)
