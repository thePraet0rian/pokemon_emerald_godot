extends CanvasLayer


@onready var timer: Timer = $timer
@onready var label: Label = $label
@onready var audio_player: AudioStreamPlayer = $audio_stream_player

var text_arr: Array
var current_index: int = 0
var current_line: int = 2
var pressed: bool = true


func set_text(input: Array) -> void:
	
	text_arr = input


func _ready() -> void:
	
	print(text_arr)
	print("ready")
	
	var first_line: int = 1
#	first_line = int(len(text_arr) > 2) + 1
	
	label.text = ""
	
	for i in range(first_line):
		for j in range(len(text_arr[0][i])):
			
			await timer.timeout
			label.text += text_arr[0][i][j]
	
	pressed = false 


func _input(event: InputEvent) -> void:
	
	if event.is_action_pressed("space") and !pressed:
		
		audio_player.play()
		
		pressed = true
		
		print(current_line)
		
		if current_line >= len(text_arr[current_index]):
			
			label.text = ""
			current_index += 1
			current_line = 0
		
		if current_index >= len(text_arr):
			
			await audio_player.finished
			global.emit_signal("end_dialogue")
			print("end_dialogue")
		else:
			
			label.text = label.text.erase(0, label.text.find("\n") + 1)
			
			for j in range(len(text_arr[current_index][current_line])):
				
				await timer.timeout
				label.text += text_arr[current_index][current_line][j]
			
			current_line += 1
			
		
		pressed = false
