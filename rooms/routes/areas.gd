extends Area2D



@export var area_number: int = 0

var current_active: bool = false

const areas: Array = []


func _ready() -> void:
	
	get_child(0).visible = false
	global.connect("enter_new_room", Callable(self, "enter_new_room"))


func enter_new_room(active_rooms: Array, current_room: int) -> void:
	
	if area_number in active_rooms:
		
		if current_room == area_number:
			current_active = true
		
		call_deferred("enable_collision")
	else:
		
		call_deferred("disable_collision")


func disable_collision() -> void:
	
	$collision_polygon_2d.disabled = true
	get_child(0).visible = false


func enable_collision() -> void:
	
	$collision_polygon_2d.disabled = false
	get_child(0).visible = true


func _on_area_entered(area: Area2D) -> void:
	
	if "on_entered" in area.name and !current_active:
		
		global.emit_signal("enter_new_area", area_number)


func _on_area_exited(area: Area2D) -> void:
	
	if "on_entered" in area.name:
		current_active = false
