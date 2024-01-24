extends Node2D


const bag_textures: Array[Resource] = [preload("res://battle_assets/bag_assets/bag_01.png"), preload("res://battle_assets/bag_assets/bag_02.png"), preload("res://battle_assets/bag_assets/bag_03.png"), preload("res://battle_assets/bag_assets/bag_04.png"), preload("res://battle_assets/bag_assets/bag_05.png")]

@onready var bag_sprite: Sprite2D = $bag
@onready var point_sprite: Sprite2D = $point
@onready var menue_label: Label = $label


func _ready():
	pass
