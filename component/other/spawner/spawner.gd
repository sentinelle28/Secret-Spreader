extends Node2D

@export var spawn_map:TileMapLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child:Node in get_parent().get_children():
		if child is GoofyMen:
			child.global_position = spawn_map.map_to_local(spawn_map.get_used_cells().pick_random())
