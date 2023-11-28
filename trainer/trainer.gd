extends StaticBody2D


@export var pokemon_arr: Array = [[0, "Rayquaza", 100, 100, 100, 100, 100, 100, 100]]
@export var pokemon_moveset: Array = [["Tackle"]]


const trainer_battle: int = 1


func _on_area_2d_area_entered(area: Area2D) -> void:
	
	if area.name == "on_entered":
		
		global.start_battle.emit(pokemon_arr, pokemon_moveset, trainer_battle)
