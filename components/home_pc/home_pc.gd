extends CanvasLayer


@onready var background: Node2D = $background
@onready var main_menue_nde: Node2D = $main_menue
@onready var text_box_nde: Label = $sprite_2d/textbox


enum states {main_menue = 0, item_storage = 1, mailbox = 2, turn_off = 3, none = 4}


var current_state: states = states.main_menue


func _ready() -> void:
	
	background.visible = false
	main_menue_nde.visible = false
	
	global.start_dialogue.emit([["May booted up the PC\n"], ["What would you like to do"]], false)
	await global.end_dialogue
	
	background.visible = true
	main_menue_nde.visible = true
	
	current_state = states.main_menue


func _input(event: InputEvent) -> void:
	
	match current_state:
		
		states.main_menue:
			
			main_menue(event)


@onready var main_menue_cursor: Sprite2D = $main_menue/cursor

const main_menue_positions: Array = [Vector2(15, 19), Vector2(15, 36), Vector2(15, 53), Vector2(15, 70)]

var main_menue_index: int = 0


func main_menue(event: InputEvent) -> void:
	
	if event.is_action_pressed("move_up") and main_menue_index != 0:
		main_menue_index -= 1
	
	elif event.is_action_pressed("move_down") and main_menue_index != 3:
		main_menue_index += 1
	
	main_menue_cursor.position = main_menue_positions[main_menue_index]
	
	if event.is_action_pressed("space"):
		
		menue_execute()


func menue_execute() -> void:
	
	match main_menue_index:
		
		0:
			pass
		
		1:
			mailbox()
		
		2: 
			decoration()
		
		3:
			global.enable_player.emit()
			queue_free()


func mailbox() -> void:
	
	text_box_nde.text = ""
	
	current_state = states.none
	
	global.start_dialogue.emit([["There is no mail here."]], false)
	await global.end_dialogue
	
	reset_main_dialogue()
	current_state = states.main_menue


func decoration() -> void:
	
	text_box_nde.text = ""
	
	current_state = states.none
	
	global.start_dialogue.emit([["There are no decorations"]], false)
	await global.end_dialogue
	
	reset_main_dialogue()
	current_state = states.main_menue


const default_str: String = "What would you like to do?"


func reset_main_dialogue() -> void:
	
	current_state = states.none
	
	main_menue_nde.visible = false
	background.visible = false
	
	
	text_box_nde.text = ""
	
	for i in range(len(default_str)):
		
		text_box_nde.text += default_str[i]
		await get_tree().create_timer(0.05).timeout
	
	current_state = states.main_menue
	main_menue_nde.visible = true
	background.visible = true
