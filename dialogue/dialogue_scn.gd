extends CanvasLayer


signal line_written

@onready var timer: Timer = $timer
@onready var label: Label = $label
@onready var audio_player: AudioStreamPlayer = $audio_stream_player

var return_mode: bool 
var text: Array
var line: int = 0
var pressed: bool = true


func set_text(_input_arr: Array) -> void:
	text = _input_arr
	print(text)
func set_mode(_mode: bool) -> void:
	return_mode = _mode


func _ready() -> void:
	
	print("read")
	write_line(0)
	
	await line_written
	line = 1


func _input(event: InputEvent) -> void:
	
	if !pressed and event.is_action_pressed("space"):
		
		audio_player.play()
		pressed = true
		
		if line >= len(text):
			
			print("dialogue end")
			global.end_dialogue.emit(return_mode)
			queue_free()
		else:
			
			print("is reached")
			label.text = ""
			write_line(line)
			await line_written
			line += 1


func write_line(_line: int) -> void:
	
	if len(text) == 0:
		print("dialogue exception")
		queue_free()
	
	for i in range(len(text[_line])):
		
		await timer.timeout
		label.text += text[_line][i]
	
	pressed = false
	line_written.emit()
