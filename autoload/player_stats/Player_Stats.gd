extends Node

var base_speed:int = 300
var max_stamina:int = 100
var stamina_regen:float = 1.2
var area_of_influence:int = 12
var stamina_mult:float = 1



func _reset()->void:
	base_speed = 300
	max_stamina = 100
	stamina_regen = 1.2
	area_of_influence = 12
	stamina_mult = 1
