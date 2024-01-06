extends Node2D


const item_icons: Array[Resource] = [preload("res://item_icons/icon_00.png")]
const sub_item_scn: PackedScene = preload("res://components/home_pc/sub_item.tscn")

var items: Array[Array] = global.global_pc_storage
var item_nodes: Array[Node2D]
var item_count: int

func _ready() -> void:
	
	items.append(["Cancel", -1])
	item_count = len(items) - 8
	var zero_item_index = item_count - 1
	
	
	for i in range(len(items)):
		
		var sub_item_inst: Node2D = sub_item_scn.instantiate()
		sub_item_inst.set_sub_item(items[i])
		sub_item_inst.position = Vector2(137, 24) + i * Vector2(0, 15) - item_count * Vector2(0, 15)
		$items.add_child(sub_item_inst)
		item_nodes.append(sub_item_inst)
		
		if i < item_count:
#			sub_item_inst.visible = false
			pass


@onready var cursor: Sprite2D = $cursor
@onready var items_nde: Node2D = $items

var zero_item_index: int
var active: bool = false
var item_index: int = 0


func _input(event: InputEvent) -> void:
	
	if active:
		
		if event.is_action_pressed("move_up"):
			
			if item_index != 0:
				item_index -= 1
				cursor.position -= Vector2(0, 15)
			else:
				items_nde.position += Vector2(0, 15)
			
		elif event.is_action_pressed("move_down"):
			
			if item_index != 7:
				cursor.position += Vector2(0, 15)
				item_index += 1
			elif item_index < 0:
				items_nde.position -= Vector2(0, 15)
