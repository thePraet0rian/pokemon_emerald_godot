extends CanvasLayer


@onready var cursor: Sprite2D = $cursor

var index: int = 0


func _input(event: InputEvent) -> void:
	
	if event.is_action_pressed("move_up") and index > 0 :
		index -= 1
		cursor.position.y -= 15
	elif event.is_action_pressed("move_down") and index < 6:
		index += 1
		cursor.position.y += 15
	
	if event.is_action_pressed("space"):
		check_selection()


func check_selection() -> void:
	
	match index:
		
		0:
			pass
		1:
			pass
		2:
			pass
		3:
			pass
		4:
			global.emit_signal("save_game")
			global.emit_signal("start_dialogue", [["Saving don't turn the device off."]])
			queue_free()
		5:
			pass
			# option
		6:
			get_parent().get_node("player").process_mode = Node.PROCESS_MODE_ALWAYS
			queue_free()


func _physics_process(_delta: float) -> void:
	
	if Input.is_action_just_pressed("inventory"):
		get_parent().get_node("player").process_mode = Node.PROCESS_MODE_ALWAYS
		queue_free()
