extends StaticBody2D


@export var pokemon_arr: Array = [[[global.get_mon_number("Rayquaza"), "Rayqaza", 100, 100, 100, 100, 100, 100, 100, 100, 100], [["Takle", 30]]]]

const trainer_battle: int = 1


func _on_area_2d_area_entered(area: Area2D) -> void:
	
	if area.name == "on_entered":
		
		print(pokemon_arr)
		global.start_battle.emit(pokemon_arr, trainer_battle)
