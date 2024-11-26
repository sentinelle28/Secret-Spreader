extends Node

@export var base_speed:int = 200
@export var max_stamina:int = 100
@export var stamina_regen:float = 1.4
@export var area_of_influence:int = 12
@export var stamina_mult:float = 1.1
@export var secret_mult:float = 1
@export var better_goofy_men:int = 10

var did_cheat:bool = false

func _reset()->void:
	base_speed = 200
	max_stamina = 100
	stamina_regen = 1.4
	area_of_influence = 12
	stamina_mult = 1.1
	secret_mult = 1
	better_goofy_men = 10

func _add(propety:String,value)->void:
	match propety:
		"base_speed":
			base_speed += value
		"max_stamina":
			max_stamina += value
		"stamina_regen":
			stamina_regen += value
		"area_of_influence":
			area_of_influence += value
		"stamina_mult":
			stamina_mult += value
		"better_goofy_men":
			better_goofy_men += value
		"secret_mult":
			secret_mult += value
	
func _custom_set(_propety:String,_value:bool)->void:
	pass
	
