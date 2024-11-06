extends Node

@export var base_speed:int = 300
@export var max_stamina:int = 100
@export var stamina_regen:float = 1.2
@export var area_of_influence:int = 12
@export var stamina_mult:float = 1

var dict:Dictionary = {"base_speed":base_speed,"max_stamina":max_stamina,
"stamina_regen":stamina_regen,"area_of_influence":area_of_influence,
"stamina_mult":stamina_mult}

func _reset()->void:
	base_speed = 300
	max_stamina = 100
	stamina_regen = 1.2
	area_of_influence = 12
	stamina_mult = 1

func _add(propety:String,value)->void:
	dict[propety] += value
	
func _custom_set(propety:String,value:bool)->void:
	dict[propety] = value
	
