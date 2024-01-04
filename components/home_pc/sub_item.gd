extends Node2D


@onready var name_nde: Label = $name
@onready var count_nde: Label = $count
@onready var x_nde: Label = $label


func set_sub_item(item: Array) -> void:
	
	await ready
	
	name_nde.text = str(item[0])
	
	if item[1] == -1:
		x_nde.visible = false
		count_nde.visible = false
	else:
		count_nde.text = str(item[1])
