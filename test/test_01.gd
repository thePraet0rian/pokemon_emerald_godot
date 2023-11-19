extends StaticBody2D



func _input(event: InputEvent) -> void:
	
	$collision_polygon_2d.visible = get_tree().debug_collisions_hint
