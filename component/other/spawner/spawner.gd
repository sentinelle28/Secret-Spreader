extends Node2D

@export var spawn_map_stocker:Node
@export var parent:Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var spawn_map:TileMapLayer = spawn_map_stocker.get_children().pick_random()
	
	for child:Node in parent.get_children():
		if child is GoofyMen:
			child.global_position = spawn_map.map_to_local(spawn_map.get_used_cells().pick_random())
