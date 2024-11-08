extends TextureButton

class_name UpgradeBase
@export_category("cost related")
@export var cost:int = 10
@export var max_upgrade:int = 1
@export var current_upgrade_level:int = 0
@export_category("benefit related")




func _ready() -> void:
	current_upgrade_level = Upgrade.get_upgrade(name)

func _on_pressed() -> void:
	if current_upgrade_level + 1 <= max_upgrade:
		if Score.spread_coins - cost >= 0:
			Score._pay(cost)
			_upgrade()
			_spawn_indicator()
			
			
"""
func _spawn_indicator()->void:
	var r:String = ""
	for i:String in related_var.split("_",false,-1):
		r += i
				
	var child:UpgradePrefab = load("res://component/other/prefab/upgrade_prefab.tscn").instantiate()
	add_child(child)
	child._set_score("+ " + r)"""
		
		
func _upgrade()->void:
	pass


func _add_point()->void:
	current_upgrade_level += 1
	Upgrade._set_upgrade(name,current_upgrade_level)
	
	



"""
func _add_power()->void:
	PlayerStats._add(related_var,power_increase)
"""
