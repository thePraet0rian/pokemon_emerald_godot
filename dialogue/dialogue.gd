extends CanvasLayer


@onready var dialog_window: Label = $dialouge_label
@onready var timer: Timer = $timer


var text: Array = []
var line: int = 0
var current_text: String = ""
var is_pressed: bool = true
var test_line: int = 1
var pressed: bool = true


func set_text(input: Array) -> void:
	text = input


func _ready() -> void:
	draw_first_two_lines(0)


func draw_first_two_lines(line_int: int) -> void:
	
	
	pressed = true
	
	current_text = ""
	
	var lines: int
	
	if len(text[line_int]) >= 2:
		lines = 2
	else:
		lines = 1
	
	var previos_i: int = 0
	
	
	for i in range(lines):
		for j in range(len(text[line_int][i])):
			
			await timer.timeout
			current_text += text[line_int][i][j]
			dialog_window.text = current_text
			
			if previos_i != i:
				dialog_window.text += "\n"
				previos_i += 1
	
#	dialog_window.text = "asdfasdf \n asdfasfd"
	
	
	is_pressed = false
	pressed = false


func _input(event: InputEvent) -> void:
	
	if event.is_action_pressed("space"):
		if !is_pressed && !pressed:
			
			is_pressed = true
			
			if test_line + 1 < len(text[line]):
				
				current_text = current_text.erase(0, current_text.find("\n") + 1)
				dialog_window.text = current_text
				
				for i in range(len(text[line][test_line + 1])):
					
					await timer.timeout
					current_text += text[line][test_line + 1][i]
					dialog_window.text = current_text
				
				test_line += 1
			
			else:
				
				if line + 1 < len(text):
					line += 1
					draw_first_two_lines(line)
					test_line = 1
				else:
					global.emit_signal("end_dialogue")
			
			is_pressed = false

