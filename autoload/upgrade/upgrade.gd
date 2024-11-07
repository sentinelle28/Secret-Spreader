extends Node


var upgrade_dict:Dictionary  = {}

func get_upgrade(upgrade_name:String)->int:
	return upgrade_dict[upgrade_name]
	
func _set_upgrade(upgrade_name:String,value:int)->void:
	upgrade_dict[upgrade_name] = value

func _reset()->void:
	upgrade_dict = {}
