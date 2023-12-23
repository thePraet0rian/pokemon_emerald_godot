extends CanvasLayer


@onready var minute_hand: Sprite2D = $organize/minute_hand
@onready var hour_hand: Sprite2D = $organize/hour_hand
@onready var am_pm_dial: Sprite2D = $organize/am_pm_dial

const sprites: Array = [preload("res://room_assets/clock/am_sign.png"), preload("res://room_assets/clock/pm_sign.png")]


var time_in_minutes: int = 0
var am: bool = true


func _input(event: InputEvent) -> void:
	
	
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
		
		pass
