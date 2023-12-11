extends Area2D


@export var event: String = ""


func _on_area_entered(area: Area2D) -> void:
	
	if area.name == "on_entered":
		global.object.emit(event)
