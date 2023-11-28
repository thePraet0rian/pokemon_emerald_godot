extends Area2D



@export var area_number: int = 0

var current_active: bool = false
var currently_instanced: bool = false

const areas: Array = [preload("res://rooms/routes/arr_00.tscn"), preload("res://rooms/routes/arr_01.tscn"), preload("res://rooms/routes/arr_02.tscn"), preload("res://rooms/routes/arr_03.tscn"), preload("res://rooms/routes/arr_04.tscn"), preload("res://rooms/routes/arr_05.tscn"), preload("res://rooms/routes/arr_06.tscn"), preload("res://rooms/routes/arr_07.tscn")]


func _ready() -> void:
	get_child(0).queue_free()
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
	
	for i in range(0, len(get_children())):
		if "arr" in get_child(i).name:
			get_child(1).queue_free()
			currently_instanced = false


func enable_collision() -> void:
	
	$collision_polygon_2d.disabled = false
	
	if !currently_instanced:
		var child: Node2D = areas[area_number].instantiate()
		add_child(child)
		currently_instanced = true


func _on_area_entered(area: Area2D) -> void:
	
	if "on_entered" in area.name and !current_active:
		
		global.emit_signal("enter_new_area", area_number)


func _on_area_exited(area: Area2D) -> void:
	
	if "on_entered" in area.name:
		current_active = false
