extends Node2D


const item_icons: Array[Resource] = [preload("res://item_icons/icon_00.png")]
const sub_item_scn: PackedScene = preload("res://components/home_pc/sub_item.tscn")

var items: Array[Array] = global.global_pc_storage
var item_count: int

func _ready() -> void:
	
	items.append(["Cancel", -1])
	item_count = len(items) - 7
	
	for i in range(len(items)):
		
		var sub_item_inst: Node2D = sub_item_scn.instantiate()
		sub_item_inst.set_sub_item(items[i])
		sub_item_inst.position = Vector2(137, 24) + i * Vector2(0, 15) - item_count * Vector2(0, 15)
		$items.add_child(sub_item_inst)
		
		if i < item_count:
#			sub_item_inst.visible = false
			pass


var active: bool = false

func _input(event: InputEvent) -> void:
	
	if active:
		
		pass
