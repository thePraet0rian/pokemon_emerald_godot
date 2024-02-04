extends CanvasLayer
class_name option_selection

signal selection()

@onready var arrow: Sprite2D = $arrow

const arrow_positions: Array[Vector2] = [Vector2(171, 80), Vector2(171, 97)]

var activated: bool = false
var arrow_index: int = 0


func _input(event: InputEvent) -> void:
	
	if activated:
		
		if event.is_action_pressed("move_down"):
			
			if arrow_index != 1:
				arrow_index += 1
			
		elif event.is_action_pressed("move_up"):
			
			if arrow_index != 0:
				arrow_index -= 1
		
		arrow.position = arrow_positions[arrow_index]
		
		if event.is_action_pressed("space"):
			
			selection.emit(!(bool(arrow_index)))
