extends CanvasLayer
class_name inventory


func _ready() -> void:
	
	start() 


const item_scn: PackedScene = preload("res://components/item.tscn")


func start() -> void:
	
	for i in range(5):
		for j in range(len(global.player_inventory[i])):
			
			var item_inst: Label = item_scn.instantiate()
			sub[i].add_child(item_inst)
			item_inst.text = global.player_inventory[i][j][0]
			item_inst.position = Vector2(120, 24 + 16 * j)


@onready var point: Sprite2D = $point
@onready var item_info: Sprite2D = $item_sign
@onready var bag: Sprite2D = $bag
@onready var sub: Array[Node2D] = [$item, $pokeball, $tm, $berries, $key]

const point_positions: Array[Vector2] = [Vector2(44, 29), Vector2(52, 29), Vector2(60, 29), Vector2(68, 29), Vector2(76, 29)]
const bag_textures: Array = [preload("res://battle_assets/bag_assets/bag_01.png"), preload("res://battle_assets/bag_assets/bag_02.png"), preload("res://battle_assets/bag_assets/bag_03.png"), preload("res://battle_assets/bag_assets/bag_04.png"), preload("res://battle_assets/bag_assets/bag_05.png")]
const info_textures: Array = [preload("res://battle_assets/bag_assets/item_sign.png"), preload("res://battle_assets/bag_assets/pokeball_sign.png"), preload("res://battle_assets/bag_assets/tmandhm_sign.png"), preload("res://battle_assets/bag_assets/berries_sign.png"), preload("res://battle_assets/bag_assets/key_items_sign.png")]

var menue_index: int = 0


func _input(event: InputEvent) -> void:
	
	if event.is_action_pressed("move_left"):
		
		if menue_index != 0:
			menue_index -= 1
		else:
			menue_index = 4
		
	elif event.is_action_pressed("move_right"):
		
		if menue_index != 4:
			menue_index += 1
		else: 
			menue_index = 0
	
	point.position = point_positions[menue_index]
	item_info.texture = info_textures[menue_index]
	bag.texture = bag_textures[menue_index]
	
	for i in range(5):
		
		if i == menue_index:
			sub[i].visible = true
		else:
			sub[i].visible = false
