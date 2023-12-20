extends Node2D


func _ready() -> void:
	
	global.object.connect(disable)


func disable(event: String) -> void:
	
	if event == "a":
		call_deferred("disable_02")


func disable_02() -> void:
	
	$event/collision_polygon_2d.queue_free()
