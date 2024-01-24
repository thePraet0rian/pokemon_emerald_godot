extends Area2D


enum states {entered = 0, touched = 1}


@export var event: String = ""
@export var current_state: states = states.entered


func _ready() -> void:
	
	set_process(false)



func _on_area_entered(area: Area2D) -> void:
	
	if current_state == 0:
		
		if area.name == "on_entered":
			global.object.emit(event)
	else: 
		
		if area.name == "on_touched":
			set_process(true)


func _on_area_exited(area: Area2D) -> void:
	
	if area.name == "on_touched":
		set_process(false)


func _process(_delta: float) -> void:
	
	if Input.is_action_just_pressed("space"):
		global.object.emit(event)
		set_process(false)

