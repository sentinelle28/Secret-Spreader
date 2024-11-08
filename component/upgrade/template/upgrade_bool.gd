extends UpgradeBase

class_name UpgradeBool
@export var related_var:String = "base_speed"
@export var is_bool:bool = false
# Called when the node enters the scene tree for the first time.

func _upgrade()->void:
	_add_point()
	_activate_new_function()

func _activate_new_function()->void:
	PlayerStats._custom_set(related_var,true)
