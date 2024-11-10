@tool
extends Node2D

@export var water_map:TileMapLayer
@export var grass_map:TileMapLayer
@export var do_it:bool = false: 
	set (value):
		do_it = _set_get_reception(value)
	get:
		return do_it
	
		


func _set_get_reception(value):
	if value:
		_create_map()
	else:
		_clear_map()
	return value


func _clear_map() -> void:
	for tile:Vector2i in water_map.get_used_cells():
		water_map.erase_cell(tile)


func _create_map() -> void:
	for tile:Vector2i in grass_map.get_used_cells():
		_set_normal_water(tile)
		_check_neighboor(tile)
		

func _check_neighboor(tile:Vector2i)->void:
	for neigh:Vector2i in grass_map.get_surrounding_cells(tile):
		if grass_map.get_cell_atlas_coords(neigh) == Vector2i(-1,-1):
			_check_water_map(neigh)
			
func _check_water_map(tile:Vector2i)->void:
	if water_map.get_cell_atlas_coords(tile) == Vector2i(-1,-1):
		water_map.set_cell(tile,0,Vector2i(1,0))

func _set_normal_water(tile:Vector2i)->void:
	water_map.set_cell(tile,0,Vector2i(0,0))
