extends Area2D


const areas: Array = [preload("res://rooms/routes/arr_00.tscn"), preload("res://rooms/routes/arr_01.tscn"), preload("res://rooms/routes/arr_02.tscn"), preload("res://rooms/routes/arr_03.tscn"), preload("res://rooms/routes/arr_04.tscn"), preload("res://rooms/routes/arr_05.tscn"), preload("res://rooms/routes/arr_06.tscn"), preload("res://rooms/routes/arr_07.tscn")]

var currently_active: bool = false
var currently_instanced: bool = false

@export var area_number: int = 0


func _ready():
	
	get_child(0).queue_free()
	global.update_routes.connect(enter_new_route)


var active_rooms: Array


func enter_new_route(_active_rooms: Array) -> void:
	
	var current_route = global.current_area
	active_rooms = _active_rooms.duplicate()
	
	if area_number in active_rooms:
		
		if current_route == area_number:
			currently_active = true
		else:
			currently_active = false
		
		call_deferred("enable_collision")
		
	else:
		
		call_deferred("disable_collision")


func enable_collision() -> void:
	
	if $collision_polygon_2d != null:
		$collision_polygon_2d.disabled = false
	
	if !currently_instanced:
		var child: Node2D = areas[area_number].instantiate()
		add_child(child)
		currently_instanced = true


func disable_collision() -> void:
	
	var children: Array = get_children()
	
	for i in range(len(children)):
		
		if children[i].name != "collision_polygon_2d":
			children[i].queue_free()
			currently_instanced = false


func _on_area_entered(area: Area2D) -> void:
	
	if "on_entered" in area.name and !currently_active:
		
		print("Player Entered Route")
		global.entered_new_route.emit(area_number)


func _on_area_exited(area: Area2D) -> void:
	
	if "on_entered" in area.name:
		currently_active = false

