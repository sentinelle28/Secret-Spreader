extends UpgradeBase

class_name UpgradeBool
@export_category("benefit related")
@export var related_var:String = "base_speed"
# Called when the node enters the scene tree for the first time.

func _upgrade()->void:
	_add_point()
	_activate_new_function()
	

func _activate_new_function()->void:
	PlayerStats._custom_set(related_var,true)

func _spawn_indicator()->void:
	var child:UpgradePrefab = load("res://component/other/prefab/upgrade_prefab.tscn").instantiate()
	add_child(child)
	child._set_text("unlock " + related_var)
