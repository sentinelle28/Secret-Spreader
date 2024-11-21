extends Node2D

@export var spawn_map_stocker:Node
@export var parent:Node
@export var goofy_men_ref:PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_spawn()
	_place()

func _place()->void:
	var spawn_map:TileMapLayer = spawn_map_stocker.get_children().pick_random()
	for child:Node in parent.get_children():
		if child is GoofyMen:
			child.global_position = spawn_map.map_to_local(spawn_map.get_used_cells().pick_random())

func _spawn()->void:
	for i:int in range(Score.current_level/2):
		var child:GoofyMen = goofy_men_ref.instantiate()
		parent.add_child(child)
