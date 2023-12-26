extends CanvasLayer


func _ready() -> void:
	
	if global.events[8]:
		rotate.visible = false
		current_state = states.cant_move


enum states {cant_move = 0, can_move = 1, selected = 2}

@onready var minute_hand: Sprite2D = $organize/minute_hand
@onready var hour_hand: Sprite2D = $organize/hour_hand
@onready var am_pm_dial: Sprite2D = $organize/am_pm_dial
@onready var choice: Node2D = $selected
@onready var select: Sprite2D = $selected/sprite_2d_2/sprite_2d
@onready var rotate: Sprite2D = $organize/buttons

const sprites: Array = [preload("res://room_assets/clock/am_sign.png"), preload("res://room_assets/clock/pm_sign.png")]
const positions: Array = [Vector2(-15, -8), Vector2(-15, 7)]

var time_in_minutes: int = 0
var am: bool = true
var index: int = 0
var current_state: states = states.can_move


func _input(event: InputEvent) -> void:
	
	
	match current_state:
		
		0:
			if event.is_action_pressed("shift") or event.is_action_pressed("space"):
				
				global.object.emit("clock_set")
				queue_free()
		
		
		1:
			
			if event.is_action("move_left"):
				time_in_minutes -= 1
				
				if time_in_minutes % 720 == 0:
					time_in_minutes = 0
					am = !am
				
			elif event.is_action("move_right"):
				time_in_minutes += 1
				
				
				if time_in_minutes % 720 == 0:
					
					print("yes but y")
					
					time_in_minutes = 0
					am = !am
			
			minute_hand.rotation_degrees = (float(time_in_minutes) / 60) * 360
			hour_hand.rotation_degrees = (float(time_in_minutes) / 60) * 30
			
			if am: 
				am_pm_dial.texture = sprites[0]
			else:
				am_pm_dial.texture = sprites[1]
			
			if event.is_action_pressed("space"):
				
				current_state = 2
				choice.visible = true
		
		
		2:
			
			if event.is_action_pressed("move_up") and index != 0:
				index -= 1
				select.position = positions[0]
			elif event.is_action_pressed("move_down") and index != 1:
				select.position = positions[1]
				index += 1
			
			if event.is_action_pressed("shift"):
				
				current_state = 1
				choice.visible = false
				
			elif event.is_action_pressed("space"):
				
				if index == 0:
					
					global.object.emit("clock_set")
					global.time = time_in_minutes
					queue_free()
					
				elif index == 1:
					
					current_state = 1
					choice.visible = false
