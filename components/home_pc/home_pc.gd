extends CanvasLayer


@onready var background: Node2D = $background
@onready var main_menue_nde: Node2D = $main_menue
@onready var text_box_nde: Label = $sprite_2d/textbox


enum states {main_menue = 0, item_storage = 1, mailbox = 2, turn_off = 3, none = 4}


var current_state: states = states.none


func _ready() -> void:
	
	background.visible = false
	main_menue_nde.visible = false
	item_storage_nde.visible = false
	
	#global.start_dialogue.emit([["May booted up the PC\n"], ["What would you like to do"]], false)
	await global.end_dialogue
	
	background.visible = true
	main_menue_nde.visible = true
	
	current_state = states.main_menue


func _input(event: InputEvent) -> void:
	
	match current_state:
		
		states.main_menue:
			
			text_box_nde.text = "What would you like to do?"
			main_menue(event)
		
		states.item_storage:
			
			text_box_nde.text = "Take out items from the PC."
			item_storage(event)


@onready var main_menue_cursor: Sprite2D = $main_menue/cursor

const main_menue_positions: Array[Vector2] = [Vector2(15, 19), Vector2(15, 36), Vector2(15, 53), Vector2(15, 70)]

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
			main_menue_nde.visible = false
			background.visible = false
			
			await get_tree().create_timer(.45).timeout
			
			text_box_nde.text = menue_text_arr[item_storage_index]
			item_storage_nde.visible = true
			background.visible = true
			
			current_state = states.item_storage
		
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
	
	#global.start_dialogue.emit([["There is no mail here."]], false)
	await global.end_dialogue
	
	text_box_nde.text = "What would you like to do?"
	current_state = states.main_menue


func decoration() -> void:
	
	text_box_nde.text = ""
	
	current_state = states.none
	
	#global.start_dialogue.emit([["There are no decorations"]], false)
	await global.end_dialogue
	
	text_box_nde.text = "What would you like to do?"
	current_state = states.main_menue


@onready var item_storage_nde: Node2D = $item_storage
@onready var item_storage_cursor: Sprite2D = $item_storage/cursor

const menue_text_arr: Array[String] = ["Take out items form the PC.", "Store items in the PC.", "Throw away items stored in the PC.", "Go back to the \npreviouse menu."]
const item_storage_menue_positions: Array[Vector2] = [Vector2(15, 19), Vector2(15, 36), Vector2(15, 53), Vector2(15, 70)]

var item_storage_index: int = 0


func item_storage(event: InputEvent) -> void:
	
	if event.is_action_pressed("move_up"):
		
		if item_storage_index == 0:
			item_storage_index = 3
		else:
			item_storage_index -= 1
		
	elif event.is_action_pressed("move_down"):
		
		if item_storage_index == 3:
			item_storage_index = 0
		else:
			item_storage_index += 1
	
	text_box_nde.text = menue_text_arr[item_storage_index]
	item_storage_cursor.position = item_storage_menue_positions[item_storage_index]
	
	if event.is_action_pressed("space"):
		item_storage_execute()


@onready var withdraw_items: Node2D = $withdraw_item


func item_storage_execute() -> void:
	
	match item_storage_index:
		
		0:
			background.visible = false
			item_storage_nde.visible = false
			withdraw_items.visible = true
			withdraw_items.active = true
		
		1:
			pass
		
		2:
			pass
		
		3:
			item_storage_nde.visible = false
			background.visible = false
			
			await get_tree().create_timer(.45).timeout
			
			text_box_nde.text = "What would you like to do?"
			background.visible = true
			main_menue_nde.visible = true
			
			current_state = states.main_menue
