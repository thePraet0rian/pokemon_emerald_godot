extends CanvasLayer
class_name dialogue_layer


signal write_finished
signal dialogue_finished

@onready var dialogue_lable: Label = $dialogue_label
@onready var timer: Timer = $timer

var finished: bool = false


func reset() -> void:
	
	dialogue_lable.text = ""


func dialogue_write(input: String) -> void:
	
	for i in range(len(input)):
		
		await timer.timeout
		dialogue_lable.text += input[i]
	
	write_finished.emit()
	finished = true


func _input(event: InputEvent) -> void:
	
	if finished:
		if event.is_action_pressed("space"):
			dialogue_finished.emit()
